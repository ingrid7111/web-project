<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>產品搜尋 - 胖呆雜貨店</title>
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
        .search-form {
            margin-bottom: 20px;
        }
        .search-form input[type="text"] {
            padding: 8px;
            width: 200px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .search-form button {
            padding: 8px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .search-form button:hover {
            background-color: #45a049;
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
        .error {
            color: red;
            font-weight: bold;
        }
        .no-results {
            color: #666;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>產品搜尋</h2>
        <div class="search-form">
            <form method="post" action="searchProducts.jsp">
                <input type="text" name="keyword" placeholder="輸入產品名稱關鍵字" value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
                <button type="submit">搜尋</button>
            </form>
        </div>
        <%
            String dbUrl = "jdbc:mysql://localhost:3306/shop?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "1234"; // 請替換為你的實際資料庫密碼
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            String keyword = request.getParameter("keyword");
            if (keyword != null && !keyword.trim().isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                    // 查詢產品，使用 LIKE 進行模糊搜尋
                    String sql = "SELECT product_name, product_price, stock_quantity FROM products WHERE product_name LIKE ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, "%" + keyword.trim() + "%");
                    rs = pstmt.executeQuery();
        %>
        <table>
            <tr>
                <th>產品名稱</th>
                <th>價格</th>
                <th>庫存</th>
            </tr>
            <%
                boolean hasResults = false;
                while (rs.next()) {
                    hasResults = true;
                    String productName = rs.getString("product_name");
                    double productPrice = rs.getDouble("product_price");
                    int stockQuantity = rs.getInt("stock_quantity");
            %>
            <tr>
                <td><%= productName %></td>
                <td>NT$<%= String.format("%.2f", productPrice) %></td>
                <td><%= stockQuantity %> 件</td>
            </tr>
            <%
                }
                if (!hasResults) {
                    out.println("<p class='no-results'>無符合的產品。</p>");
                }
            %>
        </table>
        <%
                } catch (Exception e) {
                    out.println("<p class='error'>搜尋失敗：" + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            } else {
                out.println("<p class='no-results'>請輸入關鍵字進行搜尋。</p>");
            }
        %>
    </div>
</body>
</html>