<%@ page import="java.sql.*" %>
<%
String username = (String) session.getAttribute("user");
if (username == null) {
  response.sendRedirect("member-2ver.html");
  return;
}
%>

<h2>購物紀錄</h2>
<%
try {
  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/pdzhd?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei",
    "root", "1234");

  PreparedStatement stmt = conn.prepareStatement(
    "SELECT o.order_date, p.name, p.image_url, oi.quantity, oi.price FROM orders o " +
    "JOIN order_items oi ON o.id = oi.order_id " +
    "JOIN products p ON oi.product_id = p.id " +
    "WHERE o.username = ? ORDER BY o.order_date DESC");
  stmt.setString(1, username);
  ResultSet rs = stmt.executeQuery();

  while (rs.next()) {
%>
    <div class="order">
      <p><strong>日期：</strong><%= rs.getString("order_date") %></p>
      <p><strong>商品：</strong><%= rs.getString("name") %></p>
      <img src="<%= rs.getString("image_url") %>" width="100">
      <p>數量：<%= rs.getInt("quantity") %>，單價：$<%= rs.getInt("price") %></p>
    </div>
    <hr>
<%
  }
  conn.close();
} catch (Exception e) {
  out.println("錯誤：" + e.getMessage());
}
%>
