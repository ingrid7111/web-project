// 註冊/登入邏輯
document.getElementById("auth-form").addEventListener("submit", (e) => {
  e.preventDefault();

  const user = {
    name: document.getElementById("name").value,
    phone: document.getElementById("phone").value,
    email: document.getElementById("email").value,
    address: document.getElementById("address").value,
  };

  // 存入 localStorage
  localStorage.setItem("user", JSON.stringify(user));
  localStorage.setItem("orders", JSON.stringify([])); // 初始訂單資料
  localStorage.setItem("comments", JSON.stringify([])); // 初始評論資料

  showAlert("註冊/登入成功！");

  // 跳轉到會員介面
  setTimeout(() => {
    window.location.href = "member_data.html";
  }, 1500);
});

// 顯示自定義提示框
function showAlert(message) {
  const alertBox = document.getElementById("custom-alert");
  const messageElement = document.getElementById("alert-message");
  messageElement.textContent = message;
  alertBox.style.display = "flex";

  document.getElementById("close-alert-btn").addEventListener("click", () => {
    alertBox.style.display = "none";
  });
}
