<%@ page import="java.sql.*" %>
<%
    // 資料庫連線資訊（請依實際環境調整）
    String url = "jdbc:mysql://localhost:3306/your_database";
    String user = "your_user";
    String password = "your_password";

    Connection conn = null;
    PreparedStatement pstmt = null;

    // 從前端 POST 取得商品資訊
    String name = request.getParameter("name");
    String priceStr = request.getParameter("price");
    String description = request.getParameter("description");
    String image = request.getParameter("image");
    String stockStr = request.getParameter("stock");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // 載入 JDBC Driver
        conn = DriverManager.getConnection(url, user, password); // 建立資料庫連線

        // SQL 新增語句，使用 PreparedStatement 防止 SQL 注入
        String sql = "INSERT INTO products (name, price, description, image, stock) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);

        // 設定參數，並將字串型態價格與庫存轉成數字
        pstmt.setString(1, name);
        pstmt.setDouble(2, Double.parseDouble(priceStr));
        pstmt.setString(3, description);
        pstmt.setString(4, image);
        pstmt.setInt(5, Integer.parseInt(stockStr));

        int rows = pstmt.executeUpdate(); // 執行新增

        // 回傳純文字訊息給前端
        response.setContentType("text/plain; charset=UTF-8");
        if (rows > 0) {
            out.print("新增商品成功！");
        } else {
            out.print("新增商品失敗！");
        }

    } catch (Exception e) {
        e.printStackTrace(); // 發生錯誤時印出堆疊
        out.print("新增商品發生錯誤：" + e.getMessage());
    } finally {
        // 關閉資源
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
