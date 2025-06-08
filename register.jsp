<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 已登入就不允許註冊
    if (session.getAttribute("user") != null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");

    if (username != null && password != null && name != null && phone != null && email != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/pdzhd?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei",
                "root", "1234");

            // 檢查帳號是否重複
            PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM members WHERE username = ?");
            checkStmt.setString(1, username);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // 帳號已存在
                conn.close();
%>
<script>
    alert("帳號已存在，請使用其他帳號註冊。");
    history.back();
</script>
<%
            } else {
                // 帳號不存在，執行註冊
                PreparedStatement insertStmt = conn.prepareStatement(
                    "INSERT INTO members (username, password, name, phone, email) VALUES (?, ?, ?, ?, ?)");
                insertStmt.setString(1, username);
                insertStmt.setString(2, password);
                insertStmt.setString(3, name);
                insertStmt.setString(4, phone);
                insertStmt.setString(5, email);
                insertStmt.executeUpdate();
                conn.close();
%>
<script>
    alert("註冊成功！請登入。");
    window.location.href = "index.jsp";  // ✅ 或跳轉到 login.jsp
</script>
<%
            }
        } catch (Exception e) {
%>
<script>
    alert("註冊失敗：<%= e.getMessage() %>");
    history.back();
</script>
<%
        }
    } else {
%>
<script>
    alert("請填寫完整資料！");
    history.back();
</script>
<%
    }
%>
