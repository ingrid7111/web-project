// 當頁面載入時綁定按鈕事件
document.addEventListener('DOMContentLoaded', () => {
  const menuButtons = document.querySelectorAll('#menu button');
  const sections = document.querySelectorAll('.section');

  menuButtons.forEach((button) => {
    button.addEventListener('click', () => {
      // 隱藏所有區塊
      sections.forEach((section) => {
        section.style.display = 'none';
      });

      // 顯示被點擊的區塊
      const sectionId = button.getAttribute('data-section');
      document.getElementById(sectionId).style.display = 'block';
    });
  });
});
