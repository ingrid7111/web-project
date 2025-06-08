<%
String user = (String) session.getAttribute("user");
String role = (String) session.getAttribute("role");
if (user == null || !"admin".equals(role)) {
  response.sendRedirect("index.jsp");
  return;
}
%>

<h2>商家後台</h2>
<ul>
  <li><a href="admin-review.jsp">管理評論</a></li>
  <li><a href="sales-report.jsp">銷售報表</a></li>
</ul>
