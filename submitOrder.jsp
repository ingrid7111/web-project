<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Arrays" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>訂單詳情 - 胖呆雜貨店</title>
    <style>
        body {
            font-family: 'Sawarabi Mincho', sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
            border-bottom: 2px solid #ccc;
            padding-bottom: 10px;
        }
        .section {
            margin-bottom: 20px;
        }
        .section p {
            margin: 8px 0;
        }
        .item-list table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        .item-list th, .item-list td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        .item-list th {
            background-color: #f2f2f2;
        }
        .total {
            font-weight: bold;
            font-size: 1.2em;
            margin-top: 10px;
        }
        .payment-details {
            background-color: #f8f8f8;
            padding: 10px;
            border-radius: 5px;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-btn:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            font-weight: bold;
        }
        .debug {
            color: blue;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>訂單詳情</h2>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            String dbUrl = "jdbc:mysql://localhost:3306/shop?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "1234";
            Connection conn = null;
            PreparedStatement pstmtOrder = null;
            PreparedStatement pstmtItem = null;
            PreparedStatement pstmtCheckStock = null;
            PreparedStatement pstmtUpdateStock = null;
            ResultSet rs = null;
            int orderId = 0;
            String errorMessage = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                conn.setAutoCommit(false);
                out.println("<p class='debug'>資料庫連線成功</p>");

                String userName = request.getParameter("user_name");
                String userPhone = request.getParameter("user_phone");
                String userEmail = request.getParameter("user_email");
                String userAddress = request.getParameter("user_address");
                String paymentMethod = request.getParameter("payment");
                String cardNumber = request.getParameter("card_number");
                String expiryDate = request.getParameter("expiry_date");
                String[] productNames = request.getParameterValues("product_name[]");
                String[] productPrices = request.getParameterValues("product_price[]");
                String[] productQuantities = request.getParameterValues("product_quantity[]");

                if (productNames == null || productPrices == null || productQuantities == null
                    || productNames.length != productPrices.length || productPrices.length != productQuantities.length) {
                    throw new Exception("無效的商品資料");
                }

                out.println("<p class='debug'>提交的商品名稱：" + Arrays.toString(productNames) + "</p>");

                double calculatedSubtotal = 0.0;
                int[] quantities = new int[productNames.length];
                int[] stockAtOrder = new int[productNames.length];
                StringBuilder stockError = new StringBuilder();

                // 第一步：檢查庫存並儲存快照
                for (int i = 0; i < productNames.length; i++) {
                    try {
                        double price = Double.parseDouble(productPrices[i]);
                        int quantity = Integer.parseInt(productQuantities[i]);
                        quantities[i] = quantity;
                        if (price >= 0 && quantity >= 0) {
                            calculatedSubtotal += price * quantity;
                            String sqlCheckStock = "SELECT stock_quantity FROM products WHERE TRIM(product_name) = TRIM(?) FOR UPDATE";
                            pstmtCheckStock = conn.prepareStatement(sqlCheckStock);
                            pstmtCheckStock.setString(1, productNames[i]);
                            rs = pstmtCheckStock.executeQuery();
                            if (rs.next()) {
                                int stockQuantity = rs.getInt("stock_quantity");
                                stockAtOrder[i] = stockQuantity;
                                out.println("<p class='debug'>檢查庫存：商品 " + productNames[i] + "，庫存量：" + stockQuantity + "</p>");
                                if (stockQuantity < quantity) {
                                    stockError.append("商品 ").append(productNames[i]).append(" 庫存不足，僅剩 ").append(stockQuantity).append(" 件；");
                                }
                            } else {
                                stockError.append("商品 ").append(productNames[i]).append(" 不存在；");
                                stockAtOrder[i] = -1;
                            }
                            rs.close();
                            pstmtCheckStock.close();
                        } else {
                            stockAtOrder[i] = -1;
                            out.println("<p class='debug'>無效商品數據：商品 " + productNames[i] + "，價格或數量無效</p>");
                        }
                    } catch (NumberFormatException e) {
                        out.println("<p class='debug'>無效商品數據跳過：商品 " + productNames[i] + "，錯誤：" + e.getMessage() + "</p>");
                        stockAtOrder[i] = -1;
                    }
                }

                if (stockError.length() > 0) {
                    throw new Exception(stockError.toString());
                }

                double shippingFee = 0.0;
                try {
                    shippingFee = request.getParameter("shipping_fee") != null ? Double.parseDouble(request.getParameter("shipping_fee")) : 0.0;
                } catch (NumberFormatException e) {
                    shippingFee = 0.0;
                }
                double total = calculatedSubtotal + shippingFee;

                String sqlOrder = "INSERT INTO orders (user_name, user_phone, user_email, user_address, subtotal, shipping_fee, total, payment_method, card_number, expiry_date, order_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, '完成')";
                pstmtOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
                pstmtOrder.setString(1, userName != null ? userName : "");
                pstmtOrder.setString(2, userPhone != null ? userPhone : "");
                pstmtOrder.setString(3, userEmail != null ? userEmail : "");
                pstmtOrder.setString(4, userAddress != null ? userAddress : "");
                pstmtOrder.setDouble(5, calculatedSubtotal);
                pstmtOrder.setDouble(6, shippingFee);
                pstmtOrder.setDouble(7, total);
                pstmtOrder.setString(8, paymentMethod != null ? paymentMethod : "");
                pstmtOrder.setString(9, "credit-card".equals(paymentMethod) && cardNumber != null ? cardNumber : null);
                pstmtOrder.setString(10, "credit-card".equals(paymentMethod) && expiryDate != null ? expiryDate : null);
                pstmtOrder.executeUpdate();

                rs = pstmtOrder.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                    out.println("<p class='debug'>訂單創建成功，訂單編號：" + orderId + "</p>");
                }
                rs.close();

                String sqlItem = "INSERT INTO order_items (order_id, product_name, product_price, product_quantity, stock_at_order) VALUES (?, ?, ?, ?, ?)";
                String sqlUpdateStock = "UPDATE products SET stock_quantity = stock_quantity - ? WHERE TRIM(product_name) = TRIM(?)";
                pstmtItem = conn.prepareStatement(sqlItem);
                pstmtUpdateStock = conn.prepareStatement(sqlUpdateStock);
                for (int i = 0; i < productNames.length; i++) {
                    try {
                        double price = Double.parseDouble(productPrices[i]);
                        int quantity = quantities[i];
                        if (price >= 0 && quantity >= 0 && stockAtOrder[i] >= 0) {
                            pstmtItem.setInt(1, orderId);
                            pstmtItem.setString(2, productNames[i]);
                            pstmtItem.setDouble(3, price);
                            pstmtItem.setInt(4, quantity);
                            pstmtItem.setInt(5, stockAtOrder[i]);
                            pstmtItem.executeUpdate();
                            out.println("<p class='debug'>插入 order_items：商品 " + productNames[i] + "，數量：" + quantity + "，訂單時庫存：" + stockAtOrder[i] + "</p>");

                            pstmtUpdateStock.setInt(1, quantity);
                            pstmtUpdateStock.setString(2, productNames[i]);
                            int rowsAffected = pstmtUpdateStock.executeUpdate();
                            out.println("<p class='debug'>更新庫存：商品 " + productNames[i] + "，扣減數量：" + quantity + "，影響行數：" + rowsAffected + "</p>");
                            if (rowsAffected == 0) {
                                throw new SQLException("更新庫存失敗，商品：" + productNames[i] + "，可能原因：商品名稱不匹配或不存在");
                            }
                        }
                    } catch (NumberFormatException e) {
                        out.println("<p class='debug'>無效商品數據跳過：商品 " + productNames[i] + "，錯誤：" + e.getMessage() + "</p>");
                    }
                }

                conn.commit();
                out.println("<p class='debug'>事務提交成功</p>");
            } catch (Exception e) {
                if (conn != null) try { conn.rollback(); } catch (SQLException ex) {
                    out.println("<p class='debug'>回滾失敗：" + ex.getMessage() + "</p>");
                }
                errorMessage = "訂單儲存失敗：" + e.getMessage();
                out.println("<p class='debug'>錯誤詳情：" + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (pstmtOrder != null) try { pstmtOrder.close(); } catch (SQLException e) {}
                if (pstmtItem != null) try { pstmtItem.close(); } catch (SQLException e) {}
                if (pstmtCheckStock != null) try { pstmtCheckStock.close(); } catch (SQLException e) {}
                if (pstmtUpdateStock != null) try { pstmtUpdateStock.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        %>

        <% if (errorMessage != null) { %>
            <p class="error"><%= errorMessage %></p>
        <% } else { %>
            <div class="section">
                <h3>客戶信息</h3>
                <p><strong>姓名:</strong> <%= request.getParameter("user_name") != null ? request.getParameter("user_name") : "無" %></p>
                <p><strong>電話:</strong> <%= request.getParameter("user_phone") != null ? request.getParameter("user_phone") : "無" %></p>
                <p><strong>電子郵件:</strong> <%= request.getParameter("user_email") != null ? request.getParameter("user_email") : "無" %></p>
                <p><strong>地址:</strong> <%= request.getParameter("user_address") != null ? request.getParameter("user_address") : "無" %></p>
            </div>

            <div class="section item-list">
                <h3>商品清單</h3>
                <table>
                    <tr>
                        <th>商品名稱</th>
                        <th>單價</th>
                        <th>數量</th>
                        <th>小計</th>
                    </tr>
                    <%
                        String[] productNames = request.getParameterValues("product_name[]");
                        String[] productPrices = request.getParameterValues("product_price[]");
                        String[] productQuantities = request.getParameterValues("product_quantity[]");
                        double calculatedSubtotal = 0.0;

                        if (productNames != null && productPrices != null && productQuantities != null
                            && productNames.length == productPrices.length && productPrices.length == productQuantities.length) {
                            for (int i = 0; i < productNames.length; i++) {
                                try {
                                    double price = Double.parseDouble(productPrices[i]);
                                    int quantity = Integer.parseInt(productQuantities[i]);
                                    if (price >= 0 && quantity >= 0) {
                                        double itemTotal = price * quantity;
                                        calculatedSubtotal += itemTotal;
                    %>
                    <tr>
                        <td><%= productNames[i] %></td>
                        <td>NT$<%= String.format("%.2f", price) %></td>
                        <td><%= quantity %></td>
                        <td>NT$<%= String.format("%.2f", itemTotal) %></td>
                    </tr>
                    <%
                                    }
                                } catch (NumberFormatException e) {
                                    out.println("<p class='debug'>無效商品數據跳過：商品 " + productNames[i] + "</p>");
                                }
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4">無商品資料</td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>

            <div class="section">
                <h3>訂單費用</h3>
                <%
                    double shippingFee = 0.0;
                    try {
                        shippingFee = request.getParameter("shipping_fee") != null ? Double.parseDouble(request.getParameter("shipping_fee")) : 0.0;
                    } catch (NumberFormatException e) {
                        shippingFee = 0.0;
                    }
                    double total = calculatedSubtotal + shippingFee;
                %>
                <p>小計: NT$<%= String.format("%.2f", calculatedSubtotal) %></p>
                <p>運費: NT$<%= String.format("%.2f", shippingFee) %></p>
                <p class="total">總金額: NT$<%= String.format("%.2f", total) %></p>
            </div>

            <div class="section payment-details">
                <h3>支付方式</h3>
                <%
                    String paymentMethod = request.getParameter("payment");
                    if ("credit-card".equals(paymentMethod)) {
                        String cardNumber = request.getParameter("card_number") != null ? request.getParameter("card_number") : "無";
                        String maskedCardNumber = cardNumber;
                        if (cardNumber.length() >= 4) {
                            maskedCardNumber = "**** **** **** " + cardNumber.substring(cardNumber.length() - 4);
                        }
                %>
                <p><strong>支付方式:</strong> 信用卡</p>
                <p><strong>卡號:</strong> <%= maskedCardNumber %></p>
                <p><strong>到期日:</strong> <%= request.getParameter("expiry_date") != null ? request.getParameter("expiry_date") : "無" %></p>
                <p><strong>CVV:</strong> ***</p>
                <%
                    } else if ("cash-on-delivery".equals(paymentMethod)) {
                %>
                <p><strong>支付方式:</strong> 貨到付款</p>
                <%
                    } else {
                %>
                <p><strong>支付方式:</strong> 未選擇</p>
                <%
                    }
                %>
            </div>
        <% } %>

        <a href="../checkout.html" class="back-btn">返回結帳頁面</a>
    </div>
</body>
</html>