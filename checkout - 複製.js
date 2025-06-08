function toggleDropdown() {
  const dropdownMenu = document.getElementById('dropdown-menu');
  dropdownMenu.classList.toggle('show');
}

window.onclick = function (event) {
  if (!event.target.matches('.dropdown-button')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    for (var i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
};

document.addEventListener("DOMContentLoaded", () => {
  const authContainer = document.getElementById("auth-container");
  const orderConfirmationItems = document.getElementById("order-confirmation-items");
  const subtotalElement = document.getElementById("subtotal");
  const shippingFeeElement = document.getElementById("shipping-fee");
  const totalElement = document.getElementById("total");
  const paymentForm = document.getElementById("payment-form");
  const creditCardFields = document.getElementById("credit-card-fields");
  const customAlert = document.getElementById("custom-alert");

  const user = JSON.parse(localStorage.getItem("user"));
  renderUserInfo(user);

  function renderUserInfo(user) {
    const data = {
      name: user?.name || "",
      phone: user?.phone || "",
      email: user?.email || "",
      address: user?.address || ""
    };

    authContainer.innerHTML = `
      <label for="name">姓名：</label>
      <input type="text" id="name" name="user_name" value="${data.name}" required>
      <label for="phone">電話：</label>
      <input type="tel" id="phone" name="user_phone" value="${data.phone}" required>
      <label for="email">電子郵件：</label>
      <input type="email" id="email" name="user_email" value="${data.email}" required>
      <label for="address">地址：</label>
      <input type="text" id="address" name="user_address" value="${data.address}" required>
    `;
  }

  const cartItems = JSON.parse(localStorage.getItem("cartItems")) || [];
  renderSelectedItems();

  function renderSelectedItems() {
    if (cartItems.length === 0) {
      orderConfirmationItems.innerHTML = `<p>尚未選擇任何商品。</p>`;
      updateSummary(0, 0);
      return;
    }

    orderConfirmationItems.innerHTML = "";
    let subtotal = 0;

    cartItems.forEach((item, index) => {
      const itemTotal = item.price * item.quantity;
      subtotal += itemTotal;

      orderConfirmationItems.innerHTML += `
        <div class="order-item">
          <img src="${item.image}" alt="${item.name}" width="50" height="50">
          <div class="item-details">
            <h3>${item.name}</h3>
            <p>NT$${item.price} x ${item.quantity}</p>
          </div>
          <div class="item-price">NT$${itemTotal}</div>
        </div>
      `;

      // 將商品資料也加到 form 中供後端接收
      const hiddenInputs = `
        <input type="hidden" name="product_name[]" value="${item.name}">
        <input type="hidden" name="product_price[]" value="${item.price}">
        <input type="hidden" name="product_quantity[]" value="${item.quantity}">
      `;
      paymentForm.insertAdjacentHTML("beforeend", hiddenInputs);
    });

    const shippingFee = subtotal > 0 ? 50 : 0;
    const total = subtotal + shippingFee;
    updateSummary(subtotal, shippingFee);

    // 新增隱藏欄位 (傳送訂單總金額資訊)
    paymentForm.insertAdjacentHTML("beforeend", `
      <input type="hidden" name="subtotal" value="${subtotal}">
      <input type="hidden" name="shipping_fee" value="${shippingFee}">
      <input type="hidden" name="total" value="${total}">
    `);
  }

  function updateSummary(subtotal, shippingFee) {
    subtotalElement.textContent = subtotal;
    shippingFeeElement.textContent = shippingFee;
    totalElement.textContent = subtotal + shippingFee;
  }

  // 顯示/隱藏信用卡欄位
  paymentForm.addEventListener("change", (e) => {
    if (e.target.name === "payment") {
      if (e.target.value === "credit-card") {
        creditCardFields.style.display = "block";
        document.getElementById("card-number").required = true;
        document.getElementById("expiry-date").required = true;
        document.getElementById("cvv").required = true;
      } else {
        creditCardFields.style.display = "none";
        document.getElementById("card-number").required = false;
        document.getElementById("expiry-date").required = false;
        document.getElementById("cvv").required = false;
      }
    }
  });

  if (!document.querySelector('input[name="payment"][value="credit-card"]').checked) {
    creditCardFields.style.display = "none";
  }

  paymentForm.addEventListener("submit", (e) => {
    const invalidFields = Array.from(paymentForm.querySelectorAll(":invalid"));
    if (invalidFields.length > 0) {
      e.preventDefault();
      showAlert("請填寫所有必填欄位");
      return;
    }

    // 更新 localStorage 的會員資料
    const updatedUser = {
      name: document.getElementById("name").value,
      phone: document.getElementById("phone").value,
      email: document.getElementById("email").value,
      address: document.getElementById("address").value,
    };
    localStorage.setItem("user", JSON.stringify(updatedUser));

    // 更新隱藏欄位傳值到後端（form 外的 hidden input）
    document.getElementById("member-name").value = updatedUser.name;
    document.getElementById("member-phone").value = updatedUser.phone;
    document.getElementById("member-address").value = updatedUser.address;
  });

  customAlert.querySelector("button").addEventListener("click", () => {
    customAlert.style.display = "none";
  });

  function showAlert(message) {
    customAlert.querySelector("#alert-message").textContent = message;
    customAlert.style.display = "flex";
    setTimeout(() => {
      customAlert.style.display = "none";
    }, 3000);
  }
});
