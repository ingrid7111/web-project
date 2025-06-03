// 顯示登入視窗
function openLoginWindow() {
    document.getElementById('login-modal').style.display = 'block';
  }
  
  // 關閉登入視窗
  function closeLoginWindow() {
    document.getElementById('login-modal').style.display = 'none';
  }
  
  // 處理登入表單提交 (直接跳轉，不進行帳號密碼檢查)
  document.getElementById('login-form').addEventListener('submit', function(event) {
    event.preventDefault(); // 阻止表單提交的預設行為
    
    // 不進行帳號密碼驗證，直接跳轉
    localStorage.setItem('isLoggedIn', true); // 記錄用戶登入狀態
    closeLoginWindow(); // 關閉登入視窗
    window.location.href = 'member.html'; // 跳轉到會員中心頁面
  });
  