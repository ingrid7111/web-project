<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
  <meta charset="UTF-8">
  <title>新增評論</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    .review-wrapper {
      background-color: rgba(255, 255, 255, 0.95);
      max-width: 600px;
      margin: 120px auto;
      padding: 30px;
      border-radius: 16px;
      box-shadow: 0 6px 12px rgba(0,0,0,0.2);
      font-family: "微軟正黑體", sans-serif;
    }
    .review-wrapper h2 {
      color: #42563b;
      margin-bottom: 20px;
      font-size: 1.8rem;
    }
    .review-wrapper label {
      display: block;
      margin: 10px 0 5px;
      font-weight: bold;
      color: #333;
      text-align: left;
    }
    .review-wrapper input, .review-wrapper textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 1rem;
      box-sizing: border-box;
      margin-bottom: 15px;
    }
    .review-wrapper button {
      background-color: #a54427;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 1rem;
    }
    .review-wrapper button:hover {
      background-color: #42563b;
    }
    .result-message {
      margin-top: 15px;
      color: #ae4516;
      font-weight: bold;
    }
  </style>
</head>
<body>
<div class="review-wrapper">
  <h2>發表商品評論</h2>
  <form method="post">
    <label for="productId">商品 ID：</label>
    <input type="text" name="productId" id="productId">

    <label for="rating">評分（1~5）：</label>
    <input type="number" name="rating" id="rating" min="1" max="5">

    <label for="comment">評論內容：</label>
    <textarea name="comment" id="comment" placeholder="請輸入評論..."></textarea>

    <button type="submit">送出評論</button>
  </form>

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

String username = (session != null) ? (String) session.getAttribute("username") : null;
String productId = request.getParameter("productId");
String ratingStr = request.getParameter("rating");
String comment = request.getParameter("comment");

if (productId != null && ratingStr != null && comment != null) {
    if (username == null) {
%>
  <p class="result-message">⚠️ 請先登入才能留言</p>
<%
    } else {
        try {
            int rating = Integer.parseInt(ratingStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/pdzhd?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei",
                "root", "1234");

            PreparedStatement checkStmt = conn.prepareStatement(
              "SELECT COUNT(*) FROM order_items oi JOIN orders o ON oi.order_id = o.id WHERE o.username = ? AND oi.product_id = ?");
            checkStmt.setString(1, username);
            checkStmt.setString(2, productId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next() && rs.getInt(1) == 0) {
                conn.close();
%>
  <p class="result-message">⚠️ 僅限購買過該商品的會員評論</p>
<%
            } else {
                PreparedStatement stmt = conn.prepareStatement(
                    "INSERT INTO reviews (username, product_id, rating, comment, review_time) VALUES (?, ?, ?, ?, NOW())");
                stmt.setString(1, username);
                stmt.setString(2, productId);
                stmt.setInt(3, rating);
                stmt.setString(4, comment);
                stmt.executeUpdate();
                conn.close();
%>
  <p class="result-message" style="color:green;">✅ 評論成功！</p>
<%
            }
        } catch (Exception e) {
%>
  <p class="result-message">❌ 錯誤：<%= e.getMessage() %></p>
<%
        }
    }
}
%>
</div>
</body>
</html>
