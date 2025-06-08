<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>產品列表</title>
</head>
<body>
<h2>產品列表</h2>

<%
    String url = "jdbc:mysql://localhost:3306/product?useSSL=false&serverTimezone=UTC";
    String user = "root";
    String password = "wayyqx20191027";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT * FROM products"; // 請確認資料表名稱
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        if (!rs.isBeforeFirst()) {
            out.println("資料表沒有任何資料。");
        } else {
            out.println("<table border='1' cellpadding='5' cellspacing='0'>");
            out.println("<tr><th>商品名稱</th><th>價格</th></tr>");

            while (rs.next()) {
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                out.println("<tr>");
                out.println("<td>" + name + "</td>");
                out.println("<td>" + price + "</td>");
                out.println("</tr>");
            }

            out.println("</table>");
        }

    } catch (Exception e) {
        out.println("<p style='color:red;'>資料庫錯誤: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

</body>
</html>

