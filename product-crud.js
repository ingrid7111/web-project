// 等待整個 DOM 結構載入完成後執行
document.addEventListener("DOMContentLoaded", function () {
    // 解析網址列的查詢參數，取得 product 的 id（如果有的話）
    const urlParams = new URLSearchParams(window.location.search);
    const productId = urlParams.get("id");
  
    // 如果網址有帶 productId，代表是要編輯商品，就先取得該商品資料並填入表單
    if (productId) {
      fetch(`getProduct.jsp?id=${productId}`) // 向後端請求單一商品的 JSON 資料
        .then((res) => res.json()) // 解析成 JSON 物件
        .then((product) => {
          // 將取得的商品資料填入表單對應欄位
          document.getElementById("productId").value = product.product_id;
          document.getElementById("name").value = product.name;
          document.getElementById("price").value = product.price;
          document.getElementById("description").value = product.description;
          document.getElementById("image").value = product.image;
          document.getElementById("stock").value = product.stock;
        });
    }
  
    // 綁定新增商品按鈕的點擊事件
    document.getElementById("addButton").addEventListener("click", function () {
      // 準備要送出的表單資料
      const formData = new FormData();
      formData.append("name", document.getElementById("name").value);
      formData.append("price", document.getElementById("price").value);
      formData.append("description", document.getElementById("description").value);
      formData.append("image", document.getElementById("image").value);
      formData.append("stock", document.getElementById("stock").value);
  
      // 發送 POST 請求到 addProduct.jsp，新增商品
      fetch("addProduct.jsp", { method: "POST", body: formData })
        .then((res) => res.text()) // 取得後端回傳訊息（文字）
        .then((msg) => alert(msg)); // 顯示訊息給使用者
    });
  
    // 綁定更新商品按鈕的點擊事件
    document.getElementById("updateButton").addEventListener("click", function () {
      // 準備送出的表單資料（包含 product_id）
      const formData = new FormData();
      formData.append("product_id", document.getElementById("productId").value);
      formData.append("name", document.getElementById("name").value);
      formData.append("price", document.getElementById("price").value);
      formData.append("description", document.getElementById("description").value);
      formData.append("image", document.getElementById("image").value);
      formData.append("stock", document.getElementById("stock").value);
  
      // 發送 POST 請求到 updateProduct.jsp，更新商品資料
      fetch("updateProduct.jsp", { method: "POST", body: formData })
        .then((res) => res.text())
        .then((msg) => alert(msg));
    });
  
    // 綁定刪除商品按鈕的點擊事件
    document.getElementById("deleteButton").addEventListener("click", function () {
      // 準備送出的表單資料，只需要 product_id
      const formData = new FormData();
      formData.append("product_id", document.getElementById("productId").value);
  
      // 發送 POST 請求到 deleteProduct.jsp，刪除指定商品
      fetch("deleteProduct.jsp", { method: "POST", body: formData })
        .then((res) => res.text())
        .then((msg) => alert(msg));
    });
  });
  