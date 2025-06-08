<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>訂單管理 - 胖呆雜貨店</title>
    <style>
        body {
            font-family: 'Sawarabi Mincho', sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
        }
        .container {
            max-width: 1000px;
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .logout-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #f44336;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .logout-btn:hover {
            background-color: #d32f2f;
        }
        .error {
            color: red;
            font-weight: bold;
        }
        .order-details {
            margin-left: 20px;
            padding: 10px;
            background-color: #f8f8f8;
            border-radius: 5px;
        }
        .debug {
            color: blue;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>訂單管理</h2>
        <%
            // 檢查是否登入
            if (session.getAttribute("merchant") == null) {
                response.sendRedirect("loginProcess.jsp");
                return;
            }
        %>
        <p>歡迎，<%= session.getAttribute("merchant") %> | <a href="logout.jsp" class="logout-btn">登出</a></p>
        <%
            String dbUrl = "jdbc:mysql://localhost:3306/shop?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "1234"; // 替換為你的密碼
            Connection conn = null;
            PreparedStatement pstmtOrders = null;
            PreparedStatement pstmtItems = null;
            ResultSet rsOrders = null;
            ResultSet rsItems = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                // 查詢訂單，按 order_id 升序
                String sqlOrders = "SELECT * FROM orders ORDER BY order_id ASC";
                pstmtOrders = conn.prepareStatement(sqlOrders);
                rsOrders = pstmtOrders.executeQuery();
        %>
        
        <table>
            <tr>
                <th>訂單編號</th>
                <th>客戶姓名</th>
                <th>總金額</th>
                <th>下單時間</th>
            </tr>
            <%
                while (rsOrders.next()) {
                    int orderId = rsOrders.getInt("order_id");
            %>
            <tr>
                <td><%= orderId %></td>
                <td><%= rsOrders.getString("user_name") %></td>
                <td>NT$<%= String.format("%.2f", rsOrders.getDouble("total")) %></td>
                <td><%= rsOrders.getTimestamp("created_at") %></td>
            </tr>
            <tr>
                <td colspan="4">
                    <div class="order-details">
                        <strong>訂單詳情：</strong><br>
                        <%
                            // 查詢訂單明細並加入庫存信息，使用 TRIM 確保 product_name 匹配
                            String sqlItems = "SELECT i.order_id, i.product_name, i.product_quantity, i.stock_at_order, p.product_price FROM order_items i LEFT JOIN products p ON TRIM(i.product_name) = TRIM(p.product_name) WHERE i.order_id = ?";
                            pstmtItems = conn.prepareStatement(sqlItems);
                            pstmtItems.setInt(1, orderId);
                            rsItems = pstmtItems.executeQuery();
                        %>
                        <table>
                            <tr>
                                <th>商品名稱</th>
                                <th>單價</th>
                                <th>數量</th>
                                <th>小計</th>
                                <th>當前庫存</th>
                            </tr>
                            <%
                                while (rsItems.next()) {
                                    String productName = rsItems.getString("product_name");
                                    double itemTotal = rsItems.getDouble("product_price") * rsItems.getInt("product_quantity");
                                    int stockQuantity = rsItems.getInt("stock_at_order"); // 使用 stock_at_order
                                    boolean isStockNull = rsItems.wasNull();
                                    out.println("<p class='debug'>商品: " + productName + ", 庫存: " + (isStockNull ? "NULL" : stockQuantity) + "</p>");
                            %>
                            <tr>
                                <td><%= productName %></td>
                                <td>NT$<%= String.format("%.2f", rsItems.getDouble("product_price")) %></td>
                                <td><%= rsItems.getInt("product_quantity") %></td>
                                <td>NT$<%= String.format("%.2f", itemTotal) %></td>
                                <td><%= isStockNull ? "商品不存在" : (stockQuantity >= 0 ? stockQuantity + " 件" : "庫存不足") %></td>
                            </tr>
                            <%
                                }
                                rsItems.close();
                                pstmtItems.close();
                            %>
                        </table>
                    </div>
                </td>
            </tr>
            <%
                }
            } catch (Exception e) {
                out.println("<p class='error'>載入訂單失敗：" + e.getMessage() + "</p>");
            } finally {
                if (rsOrders != null) try { rsOrders.close(); } catch (SQLException e) {}
                if (pstmtOrders != null) try { pstmtOrders.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        %>
        </table>
    </div>
</body>
</html>