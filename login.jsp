<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 如果已經登入，直接回首頁
    if (session.getAttribute("user") != null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        try {
            // 連接資料庫
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/pdzhd?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei",
                "root", "1234");

            // 查詢帳號密碼是否正確
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT name FROM members WHERE username = ? AND password = ?");
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // 登入成功，將會員名稱儲存到 session
                String name = rs.getString("name");
                session.setAttribute("user", name);
                conn.close();

                // 導回首頁
                response.sendRedirect("index.jsp");
            } else {
                conn.close();
%>
<script>
    alert("帳號或密碼錯誤！");
    history.back();
</script>
<%
            }
        } catch (Exception e) {
%>
<script>
    alert("登入失敗：<%= e.getMessage() %>");
    history.back();
</script>
<%
        }
    } else {
%>
<script>
    alert("請輸入帳號與密碼");
    history.back();
</script>
<%
    }
%>
