function toggleDropdown() {
  const dropdownMenu = document.getElementById('dropdown-menu');
  dropdownMenu.classList.toggle('show');
}

// 點擊其他地方時關閉下拉選單
window.onclick = function(event) {
if (!event.target.matches('.dropdown-button')) {
  var dropdowns = document.getElementsByClassName("dropdown-content");
  for (var i = 0; i < dropdowns.length; i++) {
  var openDropdown = dropdowns[i];
  if (openDropdown.classList.contains('show')) {
      openDropdown.classList.remove('show');
  }
  }
}
}
/*checkout*/
document.addEventListener("DOMContentLoaded", () => {
  const authContainer = document.getElementById("auth-container");
  const orderConfirmationItems = document.getElementById("order-confirmation-items");
  const subtotalElement = document.getElementById("subtotal");
  const shippingFeeElement = document.getElementById("shipping-fee");
  const totalElement = document.getElementById("total");
  const paymentForm = document.getElementById("payment-form");
  const creditCardFields = document.getElementById("credit-card-fields");
  const customAlert = document.getElementById("custom-alert");
  const checkoutButton = document.querySelector('form#payment-form button[type="submit"]');

  // 確保元素已加載
  if (!authContainer || !orderConfirmationItems || !subtotalElement || !shippingFeeElement || !totalElement || !paymentForm || !creditCardFields || !customAlert || !checkoutButton) {
    console.error("某些必要的元素無法找到，請檢查 HTML 結構");
    return;
  }

  // 會員資料處理
  const user = JSON.parse(localStorage.getItem("user"));
  if (user) {
    renderUserInfo(user);
  } else {
    renderRegistrationForm();
  }

  // 渲染會員資訊
  function renderUserInfo(user) {
    if (authContainer) {
      authContainer.innerHTML = `
        <form id="user-info-form">
            <label for="name">姓名：</label>
            <input type="text" id="name" value="${user.name}" required>
            <label for="phone">電話：</label>
            <input type="tel" id="phone" value="${user.phone}" required>
            <label for="email">電子郵件：</label>
            <input type="email" id="email" value="${user.email}" required>
            <label for="address">地址：</label>
            <input type="text" id="address" value="${user.address}" required>
        </form>
      `;
    }
  }

  // 渲染註冊表單
  function renderRegistrationForm() {
    if (authContainer) {
      authContainer.innerHTML = `
        <h2>會員註冊</h2>
        <form id="auth-form" class="auth-form">
            <label for="name">姓名：</label>
            <input type="text" id="name" placeholder="請輸入姓名" required>
            <label for="phone">電話：</label>
            <input type="tel" id="phone" placeholder="請輸入電話" required>
            <label for="email">電子郵件：</label>
            <input type="email" id="email" placeholder="請輸入電子郵件" required>
            <label for="address">地址：</label>
            <input type="text" id="address" placeholder="請輸入地址" required>
            <button type="submit">提交</button>
        </form>
      `;
      const authForm = document.getElementById("auth-form");
      if (authForm) {
        authForm.addEventListener("submit", (e) => {
          e.preventDefault();
          const user = {
            name: document.getElementById("name").value,
            phone: document.getElementById("phone").value,
            email: document.getElementById("email").value,
            address: document.getElementById("address").value,
          };
          localStorage.setItem("user", JSON.stringify(user));
          showAlert("註冊成功！");
          renderUserInfo(user); // 註冊成功後渲染會員資訊
        });
      }
    }
  }

  // 顯示會員註冊或更新成功的提示訊息
  function showAlert(message) {
    const alertBox = document.createElement("div");
    alertBox.classList.add("alert-box");
    alertBox.textContent = message;
    document.body.appendChild(alertBox);
    setTimeout(() => {
      alertBox.remove();
    }, 3000);
  }



     // 從 localStorage 取得購物車商品
     const cartItems = JSON.parse(localStorage.getItem("cartItems")) || [];

     // 顯示購物車商品
     function renderSelectedItems() {
         if (cartItems.length === 0) {
             orderConfirmationItems.innerHTML = `<p>尚未選擇任何商品。</p>`;
             updateSummary(0, 0);
             return;
         }
 
         orderConfirmationItems.innerHTML = cartItems
             .map((item) => {
                 const itemTotal = item.price * item.quantity;
                 return `
                     <div class="order-item">
                         <img src="${item.image}" alt="${item.name}" width="50" height="50">
                         <div class="item-details">
                             <h3>${item.name}</h3>
                             <p>NT$${item.price} x ${item.quantity}</p>
                         </div>
                         <div class="item-price">NT$${itemTotal}</div>
                     </div>
                 `;
             })
             .join("");
 
         // 計算總金額
         let subtotal = 0;
         cartItems.forEach((item) => {
             subtotal += item.price * item.quantity;
         });
 
         // 根據小計計算運費
         const shippingFee = subtotal > 0 ? 50 : 0;
         updateSummary(subtotal, shippingFee);
     }
 
     // 更新訂單總結（小計、運費、總金額）
     function updateSummary(subtotal, shippingFee) {
         subtotalElement.textContent = subtotal;
         shippingFeeElement.textContent = shippingFee;
         totalElement.textContent = subtotal + shippingFee;
     }
 
     // 初始渲染結帳頁面
     renderSelectedItems();
 

  // 動態顯示信用卡欄位
  if (paymentForm) {
    paymentForm.addEventListener("change", (e) => {
      if (e.target.name === "payment") {
        if (e.target.value === "credit-card") {
          creditCardFields.style.display = "block";  // 顯示信用卡欄位
          document.getElementById("card-number").required = true;  // 設定為必填
          document.getElementById("expiry-date").required = true;
          document.getElementById("cvv").required = true;
        } else {
          creditCardFields.style.display = "none";  // 隱藏信用卡欄位
          document.getElementById("card-number").required = false;  // 取消必填
          document.getElementById("expiry-date").required = false;
          document.getElementById("cvv").required = false;
        }
      }
    });
  }

  // 預設隱藏信用卡欄位（除非選中）
  if (!document.querySelector('input[name="payment"][value="credit-card"]').checked) {
    creditCardFields.style.display = "none";
  }

  // 提交支付表單
  if (paymentForm) {
    paymentForm.addEventListener("submit", (e) => {
      const paymentMethod = document.querySelector('input[name="payment"]:checked').value;

      // 檢查信用卡欄位是否需要檢查
      if (paymentMethod === "credit-card") {
        const creditCardFields = document.getElementById("credit-card-fields");
        creditCardFields.style.display = "block"; // 確保它是可見的
      }

      // 防止默認提交以處理驗證
      const invalidFields = Array.from(document.querySelectorAll("#payment-form :invalid"));
      if (invalidFields.length > 0) {
        e.preventDefault();
        alert("請填寫所有必填字段");
        return;
      }

      // 顯示彈出視窗
      customAlert.querySelector("#alert-message").textContent = "恭喜完成訂單";
      customAlert.style.display = "flex";
      
      
      // 隱藏結帳按鈕
      checkoutButton.style.display = "none";

      // 顯示「您的訂單」標題
      const orderTitle = document.createElement('h2');
      orderTitle.textContent = "您的訂單";
      document.querySelector('.container .left').insertBefore(orderTitle, document.querySelector('.left .recipient-info'));


      // 防止表單提交
      e.preventDefault();
    });

  }

  // 關閉彈出視窗
  customAlert.querySelector("button").addEventListener("click", () => {
    customAlert.style.display = "none";
  });
});



