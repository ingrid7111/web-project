<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
  <meta charset="UTF-8">
  <title>評論管理後台</title>
  <link rel="stylesheet" href="css/style.css"> <%-- 套用你的風格 --%>
  <style>
    .review-container {
      max-width: 1000px;
      margin: 100px auto;
      padding: 20px;
      font-family: "微軟正黑體", sans-serif;
    }

    .review-card {
      background-color: rgba(255,255,255,0.95);
      padding: 20px;
      margin-bottom: 20px;
      border-radius: 12px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.2);
      text-align: left;
    }

    .review-card h3 {
      margin: 0 0 10px;
      color: #42563b;
    }

    .review-card .info {
      font-size: 0.9rem;
      margin-bottom: 10px;
      color: #666;
    }

    .review-card .comment {
      font-size: 1rem;
      margin-bottom: 10px;
    }

    .review-card textarea {
      width: 100%;
      height: 60px;
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-family: "微軟正黑體";
      font-size: 1rem;
    }

    .review-card button {
      margin-top: 10px;
      background-color: #a54427;
      color: white;
      border: none;
      padding: 8px 16px;
      border-radius: 6px;
      cursor: pointer;
    }

    .review-card button:hover {
      background-color: #42563b;
    }

    .section-title {
      text-align: center;
      color: #a54427;
      font-size: 2rem;
      margin-bottom: 40px;
      font-weight: bold;
    }
  </style>
</head>
<body>

<div class="review-container">
  <div class="section-title">商品評論管理</div>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/pdzhd?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei",
        "root", "1234");

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM reviews ORDER BY review_time DESC");

    while (rs.next()) {
        int id = rs.getInt("id");
        String username = rs.getString("username");
        String productId = rs.getString("product_id");
        int rating = rs.getInt("rating");
        String comment = rs.getString("comment");
        String reply = rs.getString("admin_reply");
        Timestamp time = rs.getTimestamp("review_time");
%>
  <div class="review-card">
    <h3>用戶：<%= username %></h3>
    <div class="info">
      商品 ID：<%= productId %> ｜ 評分：<%= rating %> ｜ 時間：<%= time %>
    </div>
    <div class="comment">
      <strong>評論內容：</strong><br>
      <%= comment %>
    </div>
    <form method="post" action="replyReview.jsp">
      <input type="hidden" name="review_id" value="<%= id %>">
      <label for="admin_reply_<%= id %>"><strong>管理員回覆：</strong></label>
      <textarea id="admin_reply_<%= id %>" name="admin_reply"><%= reply == null ? "" : reply %></textarea>
      <button type="submit">送出回覆</button>
    </form>
  </div>
<%
    }
    conn.close();
} catch (Exception e) {
%>
  <p style="color:red; text-align:center;">❌ 錯誤：<%= e.getMessage() %></p>
<%
}
%>
</div>

</body>
</html>
