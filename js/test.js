
//1.用按鈕播放照片 2.加入圓點 3.自動播放
var slideIndex = 0;
var mytimer = null;
//showSlides(slideIndex);
autoplay(true);

function plusSlides(n) {
showSlides(slideIndex += n);
}

function currentSlide(n) {
showSlides(slideIndex = n);
}

function showSlides(n) {
clearTimeout(mytimer);
var slides = document.getElementsByClassName("mySlides");
var dots = document.getElementsByClassName("dot");
if (n >= slides.length) {
    slideIndex = 0;
}

if (n < 0) {
    slideIndex = slides.length - 1;
}

for (var i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
}

slides[slideIndex].style.display = "block";

for (var i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
}
dots[slideIndex].className += " active";
}

function autoplay(isFirst) {
var slides = document.getElementsByClassName("mySlides");

if (isFirst) {
    slideIndex = 0;
}
else {
    slideIndex++;
}

if (slideIndex > slides.length) {
    slideIndex = 0;
}

showSlides(slideIndex);
mytimer = setTimeout("autoplay()", 2000);
}

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

let currentSlideIndex = 0; // 當前起始圖片的索引
const visibleSlides = 3; // 同時顯示的圖片數量
const productWidth = 280; // 單個商品寬度 (包含邊距)

function moveSlide(direction, containerId) {
const container = document.getElementById(containerId);
const maxIndex = container.children.length - visibleSlides;

// 更新索引
if (direction === "left") {
    currentSlideIndex = Math.max(0, currentSlideIndex - 1);
} else if (direction === "right") {
    currentSlideIndex = Math.min(maxIndex, currentSlideIndex + 1);
}

// 更新滑動位置
const offset = -currentSlideIndex * productWidth;
container.style.transform = `translateX(${offset}px)`;
}



