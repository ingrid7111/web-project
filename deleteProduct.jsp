<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/your_database";
    String user = "your_user";
    String password = "your_password";

    Connection conn = null;
    PreparedStatement pstmt = null;

    String productIdStr = request.getParameter("product_id"); // 從前端取得商品編號

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // SQL 刪除語句，根據商品編號刪除
        String sql = "DELETE FROM products WHERE product_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(productIdStr));

        int rows = pstmt.executeUpdate(); // 執行刪除

        response.setContentType("text/plain; charset=UTF-8");
        if (rows > 0) {
            out.print("刪除商品成功！");
        } else {
            out.print("刪除商品失敗！");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.print("刪除商品發生錯誤：" + e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

