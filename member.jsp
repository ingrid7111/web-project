
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    // 暫時模擬登入，測試用
    if (session.getAttribute("user") == null) {
        session.setAttribute("user", "測試會員"); // ← 你可以改成你要顯示的名字
    }

    String user = (String) session.getAttribute("user");
%>



<!DOCTYPE html>
<html lang="zh-Hant">
<head>
  <meta charset="UTF-8">
  <title>會員中心</title>
  <link rel="stylesheet" href="css/member_center.css">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Dela+Gothic+One&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Sawarabi+Mincho&display=swap" rel="stylesheet">
</head>
<body>
  <header>
    <div class="header-container">
      <nav class="nav-left">
        <a href="about.html">關於我們</a>
        <div class="dropdown">
          <a href="#" class="dropdown-button" onclick="toggleDropdown()">商品分類 ▼</a>
          <div id="dropdown-menu" class="dropdown-content">
            <a href="project.html">所有商品</a>
            <a href="food.html">古味食堂</a>
            <a href="drinks.html">時光飲吧</a>
            <a href="toys.html">童趣樂園</a>
            <a href="supplies.html">懷舊良品</a>
          </div>
        </div>
      </nav>
      <h1 class="store-name"><a href="index.jsp">胖呆雜貨店</a></h1>
      <div class="nav-right">
        <a id="member-greeting"><%= user != null ? user + "，您好｜" : "歡迎光臨｜" %></a>
        <a href="shoppingcart.html" class="cart">🛒 購物車</a>
      </div>
    </div>
  </header>

  <main>
    <div class="content-wrapper">
      <aside>
        <ul id="menu">
          <li><button data-section="purchase-history">購物記錄</button></li>
          <li><button data-section="past-reviews">過去評論</button></li>
        </ul>
      </aside>

      <section id="content">
        <!-- 購物記錄 -->
        <div id="purchase-history" class="section" style="display: none;">
          <h2>꙳⸌♡⸍꙳ 購物記錄꙳⸌♡⸍꙳</h2>
          <div class="order">
            <p class="order-date">2024/01/01</p>
            <div class="order-item">
              <img src="image/food/chocolate.png" alt="巧克力風味醬" class="item-image">
              <div class="item-details">
                <p class="item-name">巧克力風味醬</p>
                <p class="item-price">$20</p>
              </div>
            </div>
          </div>
          <div class="order">
            <p class="order-date">2023/12/15</p>
            <div class="order-item">
              <img src="image/drinks/MarbleSoda.PNG" alt="彈珠汽水" class="item-image">
              <div class="item-details">
                <p class="item-name">彈珠汽水</p>
                <p class="item-price">$70</p>
              </div>
            </div>
          </div>
        </div>

        <!-- 過去評論 -->
        <div id="past-reviews" class="section" style="display: none;">
          <h2>꙳⸌♡⸍꙳ 過去評論꙳⸌♡⸍꙳</h2>
          <div class="review">
            <p class="reviewer-name">黃胖呆</p>
            <div class="review-rating">★★★★☆</div>
            <p class="review-text">已購買，胖呆愛吃</p>
            <span class="review-date">2024/12/30</span>
          </div>
        </div>
      </section>
    </div>
  </main>

  <footer>
    <div class="footer-container">
      <div class="footer-item">
        <img src="image/photo13.jpg" height="100px" width="150px">
        <div class="text-container">
          <p>𖥠 中原大學資管系</p>
          <p>☼ 全日公休（食物被代言人吃完 補貨中~_~）</p>
          <p>☏ 0959277777(我就愛吃吃吃吃吃)</p>
          <p>✉ pdhjzhd@gmail.com</p>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <p>@2024 胖呆懷舊雜貨店</p>
    </div>
  </footer>

  <script src="js/member_center.js"></script>
  <script src="js/test.js"></script>
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const menuButtons = document.querySelectorAll("#menu button");
      const sections = document.querySelectorAll(".section");
      menuButtons.forEach(btn => {
        btn.addEventListener("click", () => {
          const target = btn.getAttribute("data-section");
          sections.forEach(sec => {
            sec.style.display = (sec.id === target) ? "block" : "none";
          });
        });
      });
    });
  </script>
</body>
</html>
