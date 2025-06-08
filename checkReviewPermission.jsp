<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
  response.setContentType("application/json;charset=UTF-8");
  HttpSession session = request.getSession(false);
  String user = (session != null) ? (String) session.getAttribute("username") : null;
  String productId = request.getParameter("productId");
  boolean canReview = false;

  if (user != null && productId != null) {
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/pdzhd?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei",
        "root", "1234");

      PreparedStatement stmt = conn.prepareStatement(
        "SELECT * FROM order_details WHERE username = ? AND product_id = ?");
      stmt.setString(1, user);
      stmt.setString(2, productId);
      ResultSet rs = stmt.executeQuery();
      canReview = rs.next();
      conn.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  out.print("{\"canReview\": " + canReview + ", \"isLogin\": " + (user != null) + "}");
%>
