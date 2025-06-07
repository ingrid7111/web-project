<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>胖呆懷舊雜貨店</title>
  <link rel="stylesheet" href="css/test.css">
  <link rel="stylesheet" href="css/member-2ver.css">

  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Dela+Gothic+One&display=swap" rel="stylesheet">

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Sawarabi+Mincho&display=swap" rel="stylesheet">
</head>
<body>
  <div id="ad-overlay" class="overlay">
  <div class="popup-ad">
  <span class="close-btn" onclick="closeAd()">&times;</span>
  <a id="popup-ad-link" href="#">
    <div class="popup-img-wrapper">
      <img id="popup-ad-img" src="" alt="廣告圖片">
      <div class="popup-ad-text">🎉 全館免運 + 滿千折百!🎉</div>
    </div>
  </a>
  <button id="member-discount-btn" onclick="openBenefitModal()">➡️ 點擊查看會員專屬優惠 ⬅️</button>
</div>
</div>
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
          
            <!-- header 裡的會員中心區塊改為下拉選單 -->
<div class="dropdown">
  <a href="#" class="dropdown-button" onclick="toggleMemberMenu()" id="member-button">會員中心 ▼</a>
  <div id="member-menu" class="dropdown-content">
    <a href="#" onclick="openLoginWindow()">會員登入</a>
    <a href="#" onclick="openRegisterWindow()">新用戶註冊</a>
  </div>
</div>


         <!-- 🔽 新用戶註冊視窗 -->
<div id="register-modal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeRegisterWindow()">&times;</span>
    <h2>新用戶註冊</h2>
    <form id="register-form">
      <label for="name">姓名：</label>
      <input type="text" id="name" name="name" required><br>
      <label for="phone">電話：</label>
      <input type="tel" id="phone" name="phone" required><br>
      <label for="email">Email：</label>
      <input type="email" id="email" name="email" required><br>
      <label for="register-username">帳號：</label>
      <input type="text" id="register-username" name="username" required><br>

      <label for="register-password">密碼：</label>
      <input type="password" id="register-password" name="password" required><br>

      <button type="submit">註冊</button>
    </form>
    <p id="register-success" style="color: green; display: none;">註冊成功，歡迎選購！</p>
  </div>
</div>



            <!-- 登入視窗 -->
            <div id="login-modal" class="modal">
              <div class="modal-content">
                <span class="close" onclick="closeLoginWindow()">&times;</span>
                <h2>會員登入</h2>
                <form id="login-form">
                  <label for="username">帳號:</label>
                  <input type="text" id="login-username" name="username" required><br>
                  <label for="password">密碼:</label>
                  <input type="password" id="login-password" name="password" required><br>
                  <button type="submit">登入</button>
                </form>
                <p id="error-message" style="color: red; display: none;">帳號或密碼錯誤！</p>
              </div>
            </div>


            <a href="shoppingcart.html" class="cart">🛒 購物車</a>
          </div>
        </div>
    </header>
      

    <main>
          <!-- 首頁 Banner -->

          <!-- 🎉 特惠跑馬燈 -->
        <div class="marquee">
          <p>🎉 本週特惠：全館免運＋滿千享9折優惠，再送100元購物金！快來搶購口紅糖、蜜豆奶、彈珠汽水、懷舊零食等超人氣商品！🎉🎁🎈🛒🧸🎯🎮</p>
        </div>

        <div class="slideshow-container">
          <div class="mySlides fade">
            <a href="project.html"><img src="image/photo7.jpg" width="100%" height="100%"></a>
          </div>
      
          <div class="mySlides fade">
            <a href="project.html"><img src="image/photo8.jpg" width="100%" height="100%"></a>
          </div>
      
          <div class="mySlides fade">
            <a href="project.html"><img src="image/photo9.jpg" width="100%" height="100%"></a>
          </div>
      
          <!--左右按鈕-->
          <div class="pre" onclick="plusSlides(-1)">❮</div>
          <div class="next" onclick="plusSlides(1)">❯</div>
      
        </div>
    
        <!--顯示圓點-->
        <div style="text-align: center;">
          <span class="dot" onclick="currentSlide(0)"></span>
          <span class="dot" onclick="currentSlide(1)"></span>
          <span class="dot" onclick="currentSlide(2)"></span>
        </div>


        <!-- 商品列表 -->
        <section class="products" id="favorite-products">
          <h3 class="section-title">胖呆最愛</h3>
          <div class="product-list">
            <div class="product-wrapper">
              <div class="product-pre" onclick="moveSlide('left','favorite')">❮</div>
              <div class="product-container" id="favorite">
                <article class="product-item" data-id="food2">
                  <h4>˚ʚ♡ɞ˚口紅糖˚ʚ♡ɞ˚</h4>
                  <div class="product-img">
                    <img src="image/food/lipstick.png" width="260px" height="200px">
                  </div>
                </article>
                <article class="product-item" data-id="drinks1">
                  <h4>˚ʚ♡ɞ˚蜜豆奶˚ʚ♡ɞ˚</h4>
                  <div class="product-img">
                    <img src="image/drinks/soymilk.png" width="260px" height="200px">
                  </div>
                </article>
                <article class="product-item" data-id="toys1">
                  <h4>˚ʚ♡ɞ˚太空氣球˚ʚ♡ɞ˚</h4>
                  <div class="product-img">
                    <img src="image/toys/SpaceBalloon.PNG" width="260px" height="200px">
                  </div>
                </article>
                <article class="product-item" data-id="food1">
                  <h4>˚ʚ♡ɞ˚飛機餅乾˚ʚ♡ɞ˚</h4>
                  <div class="product-img">
                    <img src="image/food/AirplaneBiscuits.png" width="260px" height="200px">
                  </div>
                </article>
              </div>
              <div class="product-next" onclick="moveSlide('right','favorite')">❯</div>
            </div>
          </div>
        </section>

        <!-- 商品列表(2) -->
        <section class="products" id="hot-products">
          <h3 class="section-title">近期熱銷</h3>
          <div class="product-list">
            <div class="product-wrapper">
              <div class="product-pre" onclick="moveSlide('left','hot')">❮</div>
              <div class="product-container" id="hot">
                <article class="product-item" data-id="food3">
                  <h4>˚ʚ♡ɞ˚巧克力風味醬</h4>
                  <div class="product-img">
                    <img src="image/food/chocolate.png" width="260px" height="200px">
                  </div>
                </article>
                <article class="product-item" data-id="drinks4">
                  <h4>˚ʚ♡ɞ˚彈珠汽水˚ʚ♡ɞ˚</h4>
                  <div class="product-img">
                    <img src="image/drinks/MarbleSoda.PNG" width="260px" height="200px">
                  </div>
                </article>
                <article class="product-item" data-id="supplies5">
                  <h4>˚ʚ♡ɞ˚腳底按摩器˚ʚ♡ɞ˚</h4>
                  <div class="product-img">
                    <img src="image/supplies/FootMassager.PNG" width="260px" height="200px">
                  </div>
                </article>
                <article class="product-item" data-id="toys4">
                  <h4>˚ʚ♡ɞ˚紅包抽抽樂˚ʚ♡ɞ˚</h4>
                  <div class="product-img">
                    <img src="image/toys/draw.PNG" width="260px" height="200px">
                  </div>
                </article>
              </div>
              <div class="product-next" onclick="moveSlide('right','hot')">❯</div>
            </div>
          </div>
        </section>

        
        <!-- 🎁 會員優惠彈窗 -->
<div id="benefit-modal" class="modal" style="display: none;">
  <div class="modal-content" style="max-width: 500px;">
    <span class="close" onclick="closeBenefitModal()" style="float: right; font-size: 24px; cursor: pointer;">&times;</span>
    <h2 style="text-align: center;">🎉 會員專屬優惠 🎉</h2>
    <ul style="line-height: 2; font-size: 1.1em;">
      <li>📦 新會員註冊即贈 100 元購物金！</li>
      <li>🛍️ 每月 15 號會員日，享 9 折優惠！</li>
      <li>🎈 累積消費滿 $3000 再送限定懷舊小禮！</li>
      <li>🎁 不定期驚喜優惠券寄送至信箱</li>
    </ul>
  </div>
</div>

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
    </main>
    <script src="js/test.js"></script>
    <script src="js/member-2ver.js"></script>
    <script>

      document.querySelectorAll('.product-item').forEach((item) => {
        item.addEventListener('click', () => {
         const productId = item.getAttribute('data-id');
         // 跳轉到商品介紹頁，並攜帶商品 ID
         window.location.href = `product-detail.html?id=${productId}`;
        });
      });
  </script>


<script>
  const ads = [
    { img: "image/food/chocolate.png", link: "food.html?id=food1" },
    { img: "image/food/lipstick.png", link: "food.html?id=food1" },
    { img: "image/food/AirplaneBiscuits.png", link: "food.html?id=food1" },
    { img: "image/food/GummyCandy.png", link: "food.html?id=food1" },
    { img: "image/food/HawthornGrain.png", link: "food.html?id=food1" },
    { img: "image/food/SpiralCookies.png", link: "food.html?id=food1" },

    { img: "image/drinks/MarbleSoda.PNG", link: "drinks.html?id=drinks2" },
    { img: "image/drinks/AsparagusJuice.png", link: "drinks.html?id=drinks2" },
    { img: "image/drinks/IceCreamSoda.png", link: "drinks.html?id=drinks2" },
    { img: "image/drinks/QOO.png", link: "drinks.html?id=drinks2" },
    { img: "image/drinks/soymilk.png", link: "drinks.html?id=drinks2" },
    { img: "image/drinks/WhiteGourdTea.png", link: "drinks.html?id=drinks2" },

    { img: "image/supplies/FootMassager.PNG", link: "supplies.html?id=supplies3" },
    { img: "image/supplies/FeatherDust.PNG", link: "supplies.html?id=supplies3" },
    { img: "image/supplies/FloridaWater.PNG", link: "supplies.html?id=supplies3" },
    { img: "image/supplies/RootOfMoghania.PNG", link: "supplies.html?id=supplies3" },
    { img: "image/supplies/scratch.PNG", link: "supplies.html?id=supplies3" },
    { img: "image/supplies/SxrapingBoard.PNG", link: "supplies.html?id=supplies3" },

    { img: "image/toys/SpaceBalloon.PNG", link: "toys.html?id=toys4" },
    { img: "image/toys/PokingLottery.PNG", link: "toys.html?id=toys4" },
    { img: "image/toys/kendama.PNG", link: "toys.html?id=toys4" },
    { img: "image/toys/hopter.PNG", link: "toys.html?id=toys4" },
    { img: "image/toys/draw.PNG", link: "toys.html?id=toys4" },
    { img: "image/toys/FishingGame.PNG", link: "toys.html?id=toys4" }
  ];

  const randomAd = ads[Math.floor(Math.random() * ads.length)];
  document.getElementById("popup-ad-img").src = randomAd.img;
  document.getElementById("popup-ad-link").href = randomAd.link;
  document.getElementById("ad-description").textContent = randomAd.desc;

  
 function openBenefitModal() {
  document.getElementById("benefit-modal").style.display = "block";
  document.getElementById("ad-overlay").style.display = "none"; // 🧠 同時關閉廣告
}

 function closeBenefitModal() {
  document.getElementById("benefit-modal").style.display = "none";
}


  function closeAd() {
    document.getElementById("ad-overlay").style.display = "none";
  }
</script>

<script>
document.addEventListener("DOMContentLoaded", function () {
  // 🔄 會員選單控制
  function toggleMemberMenu() {
    document.getElementById("member-menu").classList.toggle("show");
  }
  window.toggleMemberMenu = toggleMemberMenu;

  function openRegisterWindow() {
    document.getElementById("register-modal").style.display = "block";
  }
  window.openRegisterWindow = openRegisterWindow;

  function closeRegisterWindow() {
    document.getElementById("register-modal").style.display = "none";
  }
  window.closeRegisterWindow = closeRegisterWindow;

  function openLoginWindow() {
    document.getElementById("login-modal").style.display = "block";
  }
  window.openLoginWindow = openLoginWindow;

  function closeLoginWindow() {
    document.getElementById("login-modal").style.display = "none";
  }
  window.closeLoginWindow = closeLoginWindow;

  // ✅ 註冊事件綁定
  const registerForm = document.getElementById("register-form");
  if (registerForm) {
    registerForm.addEventListener("submit", function (e) {
      e.preventDefault();
      const formData = new FormData();
      formData.append("action", "register");
      formData.append("username", document.getElementById("register-username").value);
      formData.append("password", document.getElementById("register-password").value);
      formData.append("name", document.getElementById("name").value);
      formData.append("phone", document.getElementById("phone").value);
      formData.append("email", document.getElementById("email").value);

      fetch("user.jsp", {
        method: "POST",
        body: formData
      })
        .then(res => res.text())
        .then(result => {
          if (result.includes("register_success")) {
            document.getElementById("register-success").style.display = "block";
            setTimeout(() => {
              closeRegisterWindow();
              registerForm.reset();
              document.getElementById("register-success").style.display = "none";
            }, 2000);
          } else {
            alert("註冊失敗：" + result);
          }
        });
    });
  }

  // ✅ 登入事件綁定
  const loginForm = document.getElementById("login-form");
  if (loginForm) {
    loginForm.addEventListener("submit", function (e) {
      e.preventDefault();
      const formData = new FormData();
      formData.append("action", "login");
      formData.append("username", document.getElementById("login-username").value);
      formData.append("password", document.getElementById("login-password").value);

      fetch("user.jsp", {
        method: "POST",
        body: formData
      })
        .then(res => res.text())
        .then(result => {
          const errorMessage = document.getElementById("error-message");
          if (result.includes("login_success")) {
            alert("登入成功！");
            closeLoginWindow();
            loginForm.reset();
            errorMessage.style.display = "none";

            const memberButton = document.getElementById("member-button");
            if (memberButton) {
              const name = result.split("|")[1] || "會員";
              memberButton.innerText = name + "，您好 ▼";
            }
          } else {
            if (errorMessage) {
              errorMessage.textContent = "登入失敗：" + result;
              errorMessage.style.display = "block";
            }
          }
        });
    });
  }
});
</script>
</body>
</html>
