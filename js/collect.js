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
    const wishlistItemsContainer = document.getElementById("wishlist-items");
    let wishlist = JSON.parse(localStorage.getItem("wishlist")) || [];
    
    // 如果收藏清单为空，显示提示
    if (wishlist.length === 0) {
        wishlistItemsContainer.innerHTML = "<p>您尚未收藏任何商品。</p>";
        return;
    }
    
    // 动态生成收藏清单
    wishlistItemsContainer.innerHTML = '';
    wishlist.forEach((product) => {
        const productElement = document.createElement("div");
        productElement.classList.add("wishlist-item");

        // 商品内容 (直接不使用 <a> 包裹)
        productElement.innerHTML = `
            <img src="${product.image}" alt="${product.name}" class="wishlist-item-image">
            <div class="wishlist-item-info">
                <h3 class="wishlist-item-name">${product.name}</h3>
                <p class="wishlist-item-price">${product.price}</p>
            </div>
        `;
        
        // "移除" 按钮
        const removeButton = document.createElement("button");
        removeButton.textContent = "移除";
        removeButton.classList.add("remove-btn");
        removeButton.dataset.id = product.id;

        // 将移除按钮添加到商品元素
        productElement.appendChild(removeButton);

        // 将商品元素添加到收藏清单容器
        wishlistItemsContainer.appendChild(productElement);
    });

    // 处理移除按钮
    wishlistItemsContainer.addEventListener("click", (event) => {
        if (event.target.classList.contains("remove-btn")) {
            const productId = parseInt(event.target.dataset.id);

            // 从收藏清单中移除该商品
            wishlist = wishlist.filter((item) => item.id !== productId);
            localStorage.setItem("wishlist", JSON.stringify(wishlist));

            // 移除对应的 DOM 元素
            event.target.closest(".wishlist-item").remove();

            // 如果收藏清单为空，显示提示
            if (wishlist.length === 0) {
                wishlistItemsContainer.innerHTML = "<p>您尚未收藏任何商品。</p>";
            }
        }
    });
});

// 添加商品到收藏清单时，检查是否已有该商品
const addToWishlist = (product) => {
    let wishlist = JSON.parse(localStorage.getItem("wishlist")) || [];

    // 检查是否已存在相同的商品，避免重复添加
    const isProductExist = wishlist.some(item => item.id === product.id);
    if (isProductExist) {
        alert("该商品已经在收藏清单中！");
        return; // 商品已经存在，直接返回
    }

    // 如果没有重复，添加商品到收藏清单
    wishlist.push(product);
    localStorage.setItem("wishlist", JSON.stringify(wishlist));

    // 刷新页面显示收藏清单
    renderWishlist();
};

// 刷新页面渲染收藏清单
const renderWishlist = () => {
    let wishlist = JSON.parse(localStorage.getItem("wishlist")) || [];
    const wishlistItemsContainer = document.getElementById("wishlist-items");

    wishlistItemsContainer.innerHTML = ''; // 清空容器
    if (wishlist.length === 0) {
        wishlistItemsContainer.innerHTML = "<p>您尚未收藏任何商品。</p>";
        return;
    }

    // 渲染商品列表
    wishlist.forEach((product) => {
        const productElement = document.createElement("div");
        productElement.classList.add("wishlist-item");

        // 直接显示商品内容（不使用 <a> 包裹）
        productElement.innerHTML = `
            <img src="${product.image}" alt="${product.name}" class="wishlist-item-image">
            <div class="wishlist-item-info">
                <h3 class="wishlist-item-name">${product.name}</h3>
                <p class="wishlist-item-price">${product.price}</p>
            </div>
        `;
        
        // "移除" 按钮
        const removeButton = document.createElement("button");
        removeButton.textContent = "移除";
        removeButton.classList.add("remove-btn");
        removeButton.dataset.id = product.id;

        productElement.appendChild(removeButton);
        wishlistItemsContainer.appendChild(productElement);
    });
};

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