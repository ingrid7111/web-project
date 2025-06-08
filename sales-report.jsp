<%
String user = (String) session.getAttribute("user");
String role = (String) session.getAttribute("role");
if (user == null || !"admin".equals(role)) {
  response.sendRedirect("index.jsp");
  return;
}
%>

<h2>銷售報表</h2>
<%
try {
  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/pdzhd?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei",
    "root", "1234");

  PreparedStatement stmt = conn.prepareStatement(
    "SELECT p.name, SUM(oi.quantity) AS total_qty, SUM(oi.quantity * oi.price) AS total_revenue " +
    "FROM order_items oi JOIN products p ON oi.product_id = p.id GROUP BY oi.product_id");
  ResultSet rs = stmt.executeQuery();

  while (rs.next()) {
%>
    <div>
      <p>商品名稱：<%= rs.getString("name") %></p>
      <p>總銷售量：<%= rs.getInt("total_qty") %> 件</p>
      <p>總銷售金額：$<%= rs.getInt("total_revenue") %></p>
      <hr>
    </div>
<%
  }
  conn.close();
} catch (Exception e) {
  out.println("錯誤：" + e.getMessage());
}
%>
