<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Product Detail</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        .product {
            border: 1px solid #ccc;
            padding: 20px;
            width: 300px;
        }
        .product h2 {
            margin-top: 0;
        }
    </style>
</head>
<body>
<%
    String url = "jdbc:mysql://localhost:3306/your_database_name";
    String user = "your_db_user";
    String password = "your_db_password";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    String productId = request.getParameter("id");

    if (productId != null && productId.matches("\\d+")) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            String sql = "SELECT * FROM products WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(productId));
            rs = pstmt.executeQuery();

            if (rs.next()) {
%>
<div class="product">
    <h2><%= rs.getString("name") %></h2>
    <p><strong>Price:</strong> $<%= rs.getDouble("price") %></p>
    <p><strong>Description:</strong> <%= rs.getString("description") %></p>
    <p><strong>Inventory:</strong> <%= rs.getInt("inventory") %></p>
</div>
<%
            } else {
%>
<p>Product not found.</p>
<%
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    } else {
%>
<p>Invalid product ID.</p>
<%
    }
%>
</body>
</html>
