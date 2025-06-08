<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");

// ✅ 商家身份驗證：限制只有登入且為 admin 才能回覆
String user = (String) session.getAttribute("user");
String role = (String) session.getAttribute("role"); // 你登入 admin 時應該有存 role = "admin"
if (user == null || !"admin".equals(role)) {
    out.print("無權限回覆此評論，請以商家帳號登入");
    return;
}

// ✅ 以下是原有的處理邏輯
String id = request.getParameter("review_id");
String reply = request.getParameter("admin_reply");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/pdzhd?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei",
        "root", "1234");

    PreparedStatement stmt = conn.prepareStatement("UPDATE reviews SET admin_reply = ? WHERE id = ?");
    stmt.setString(1, reply);
    stmt.setInt(2, Integer.parseInt(id));
    stmt.executeUpdate();

    conn.close();
    response.sendRedirect("admin-review.jsp");
} catch (Exception e) {
    out.print("錯誤：" + e.getMessage());
}
%>
