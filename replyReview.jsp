<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");
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
