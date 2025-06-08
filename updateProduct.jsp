<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/your_database";
    String user = "your_user";
    String password = "your_password";

    Connection conn = null;
    PreparedStatement pstmt = null;

    // 從前端 POST 取得更新的商品資訊，包括商品編號
    String productIdStr = request.getParameter("product_id");
    String name = request.getParameter("name");
    String priceStr = request.getParameter("price");
    String description = request.getParameter("description");
    String image = request.getParameter("image");
    String stockStr = request.getParameter("stock");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // SQL 更新語句，根據 product_id 來更新
        String sql = "UPDATE products SET name = ?, price = ?, description = ?, image = ?, stock = ? WHERE product_id = ?";
        pstmt = conn.prepareStatement(sql);

        // 設定參數
        pstmt.setString(1, name);
        pstmt.setDouble(2, Double.parseDouble(priceStr));
        pstmt.setString(3, description);
        pstmt.setString(4, image);
        pstmt.setInt(5, Integer.parseInt(stockStr));
        pstmt.setInt(6, Integer.parseInt(productIdStr));

        int rows = pstmt.executeUpdate(); // 執行更新

        response.setContentType("text/plain; charset=UTF-8");
        if (rows > 0) {
            out.print("更新商品成功！");
        } else {
            out.print("更新商品失敗！");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.print("更新商品發生錯誤：" + e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

