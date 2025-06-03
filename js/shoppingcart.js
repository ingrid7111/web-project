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
document.addEventListener("DOMContentLoaded", () => {
    const cartContainer = document.getElementById("cart-container");
    const customConfirm = document.getElementById("custom-confirm");
    const confirmYes = document.getElementById("confirm-yes");
    const confirmNo = document.getElementById("confirm-no");

    let cartItems = JSON.parse(localStorage.getItem("cartItems")) || [];
    let itemToDelete = null;

    // 渲染購物車商品
    const renderCart = () => {
        if (cartItems.length === 0) {
            cartContainer.innerHTML = `<p>您的購物車是空的。</p>`;
            return;
        }

        cartContainer.innerHTML = cartItems
            .map((item) => {
                const itemTotal = item.price * item.quantity;
                return `
                    <div class="cart-item">
                        <img src="${item.image}" alt="${item.name}">
                        <div class="item-details">
                            <h3>${item.name}</h3>
                            <p>單價：NT$${item.price}</p>
                        </div>
                        <div class="item-quantity">
                            <input type="number" value="${item.quantity}" min="1" disabled>
                        </div>
                        <div class="item-price">NT$${itemTotal}</div>
                        <button class="remove-item" data-id="${item.id}">刪除</button>
                    </div>
                `;
            })
            .join("");
    };

     // 處理刪除商品
     cartContainer.addEventListener("click", (event) => {
        if (event.target.classList.contains("remove-item")) {
            const cartItemElement = event.target.closest(".cart-item"); // 找到對應的商品元素
            const id = parseInt(cartItemElement.dataset.id); // 獲取商品的 id

            // 從 DOM 中移除該商品元素
            cartItemElement.remove();

            // 更新 localStorage 中的購物車資料
            cartItems = cartItems.filter((item) => item.id !== id);
            localStorage.setItem("cartItems", JSON.stringify(cartItems));

            // 檢查購物車是否為空
            if (cartItems.length === 0) {
                cartContainer.innerHTML = `<p>您的購物車是空的。</p>`;
            }
        }
  
    });
           // 初始渲染購物車
           renderCart();
   
});

function getQueryParam(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

// 使用獲取的 productId 來顯示相應商品資訊
const productId = getQueryParam('productId');
if (productId) {
    console.log(`商品 ID: ${productId}`);
    // 根據 productId 做相應處理，比如顯示商品詳細信息
}