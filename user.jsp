<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");

String action = request.getParameter("action");
String username = request.getParameter("username");
String password = request.getParameter("password");

Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/資料庫名稱?serverTimezone=UTC",
        "root",
        "你的密碼"  // ← 請換成你的 MySQL root 密碼
    );

    if ("register".equals(action)) {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        // 確認帳號是否已存在
        String checkSql = "SELECT username FROM users WHERE username = ?";
        stmt = conn.prepareStatement(checkSql);
        stmt.setString(1, username);
        rs = stmt.executeQuery();
        if (rs.next()) {
            out.print("error: 此帳號已存在");
        } else {
            rs.close();
            stmt.close();

            String insertSql = "INSERT INTO users (username, password, name, phone, email, reg_time, role) VALUES (?, ?, ?, ?, ?, NOW(), 'member')";
            stmt = conn.prepareStatement(insertSql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, name);
            stmt.setString(4, phone);
            stmt.setString(5, email);
            stmt.executeUpdate();
            out.print("register_success");
        }

    } else if ("login".equals(action)) {
        String loginSql = "SELECT name FROM users WHERE username = ? AND password = ?";
        stmt = conn.prepareStatement(loginSql);
        stmt.setString(1, username);
        stmt.setString(2, password);
        rs = stmt.executeQuery();

        if (rs.next()) {
            String name = rs.getString("name");
            out.print("login_success|" + name);  // 前端會顯示名稱
        } else {
            out.print("error: 帳號或密碼錯誤");
        }

    } else {
        out.print("error: 無效的 action 參數");
    }

} catch (Exception e) {
    out.print("error: " + e.getMessage());
} finally {
    if (rs != null) rs.close();
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
}
%>
