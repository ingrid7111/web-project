<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="javax.servlet.http.*, java.sql.*, org.json.JSONObject" %>

<%
String productId = request.getParameter("productId");
HttpSession session = request.getSession();
String username = (String) session.getAttribute("user");
boolean isLogin = (username != null);
boolean canReview = false;

if (isLogin) {
  // DB 資料庫驗證該會員是否購買過此商品（根據你的購物紀錄設計）
  try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pdzhd", "root", "1234");
    PreparedStatement stmt = conn.prepareStatement(
      "SELECT COUNT(*) FROM orders WHERE username=? AND product_id=?"
    );
    stmt.setString(1, username);
    stmt.setString(2, productId);
    ResultSet rs = stmt.executeQuery();
    if (rs.next() && rs.getInt(1) > 0) {
      canReview = true;
    }
    conn.close();
  } catch (Exception e) {
    e.printStackTrace();
  }
}

JSONObject json = new JSONObject();
json.put("isLogin", isLogin);
json.put("canReview", canReview);
out.print(json.toString());
%>
