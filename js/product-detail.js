// 商品數據
const products = {
    food1: {
        name: "飛機餅乾",
        price: "NT$50",
        originalPrice: "NT$100",
        volume:0,
        description:"古早味的飛機餅乾，散發淡淡牛奶清香，簡單的味道充滿童年美好的回憶 ✈︎\n是充滿歷史記憶卻又歷久彌新的國民餅乾!\n※餅乾類皆屬易碎品，運送過程中如有壓碎恕不退換",
        image: "image\\food\\AirplaneBiscuits.png"
    },
    food2: {
        name: "口紅糖",
        price: "NT$35",
        originalPrice: "NT$70",
        volume:0,
        description:"葡萄成分：砂糖、麥芽糖、調味劑(乳酸)、香料(葡萄)、著色劑(食用紅色40號、食用藍色1號)\n草莓成分：砂糖、麥芽糖、調味劑(乳酸)、香料(草莓)、著色劑(食用紅色40號)\n櫻桃成分：砂糖、麥芽糖、調味劑(乳酸)、香料(櫻桃)、著色劑(食用紅色40號)\n※每一份量14g/本包裝含1份：熱量52大卡",
        image: "image\\food\\lipstick.png"
    },
    
    food3: {
        name: "巧克力風味醬",
        price: "NT$20",
        originalPrice: "NT$40",
        volume:20,
        description:"這不是牙膏，這是巧克力醬，只是牙膏形狀 ╮(′～‵〞)╭\n這個超級童年\n媽媽十塊的年代，超復古\n※直接吃還是擠吐司上都可以",
        image: "image\\food\\chocolate.png"
    },
    food4: {
        name: "陳年仙楂丸",
        price: "NT$10",
        originalPrice: "NT$20",
        volume:20,
        description:"懷舊零食\n粒狀仙楂梅、仙楂丸\n酸酸甜甜，解饞小零嘴",
        image: "image\\food\\HawthornGrain.png"
    },
    food5: {
        name: "豬耳朵",
        price: "NT$55",
        originalPrice: "NT$110",
        volume:20,
        description:"台灣相當古早味的餅乾，外型為圓形，口感酥脆，無添加色素及人工香料\n內容物：麵粉(小麥麵粉、維生素C)、棕櫚油、砂糖、黑糖、鹽、黑芝麻、五香粉(肉桂、八角、小茴香、花椒、丁香)、小蘇打",
        image: "image\\food\\SpiralCookies.png"
    },
    food6: {
        name: "可樂橡皮糖",
        price: "NT$10",
        originalPrice: "NT$20",
        volume:20,
        description:"重量:200g|400g|3000g(100克估計數量22個左右)\n每100公克熱量353.4大卡、蛋白質7.8公克、碳水化合物80.5公克、糖79公克、鈉25毫克\n※保存方法:請保存陰涼乾燥處避免陽光曝曬",

        image: "image\\food\\GummyCandy.png"
    },
    drinks1: {
        name: "蜜豆奶",
        price: "NT$13",
        originalPrice: "NT$26",
        volume:0,
        description:"蜜豆奶是最佳休閒的豆奶飲料，不論何時何地都能補充所需的營養\n好喝的調味豆奶，早餐,放學後或休閒時想喝就喝\n內容物成分:水、非基因改造黃豆、蔗糖、乳糖、羧甲基纖維素鈉、食鹽、香料、脂肪酸甘油酯\n熱量:54.1大卡/100毫升",
        image: "image\\drinks\\soymilk.png"
    },
    drinks2: {
        name: "冬瓜茶",
        price: "NT$25",
        originalPrice: "NT$50",
        volume:20,
        description:"天冷加熱後加入牛奶，就是熱熱的冬瓜鮮奶\n夏天放量加入檸檬，清爽滋味，迎接夏天\n加入購物車~回味小時候吧!! ",
        image: "image\\drinks\\WhiteGourdTea.png"
    },
    drinks3: {
        name: "QOO果凍飲料",
        price: "NT$30",
        originalPrice: "NT$60",
        volume:20,
        description:"Qoo 果凍飲料 - 水蜜桃 125g\n有種果汁真好喝，喝的時候酷，喝完臉紅紅～～～喚起你過往回憶了嗎？\nQoo推出新款果凍飲料, 有水蜜桃果凍跟蘋果果凍唷",
        image: "image\\drinks\\QOO.png"
    },
    drinks4: {
        name: "彈珠汽水",
        price: "NT$35",
        originalPrice: "NT$70",
        volume:20,
        description:"最為經典的口味 傳承了百年前人所喜愛的彈珠汽水口味\n口感特別，似台灣早期的香蕉冰 小時候廟會人手一瓶， 小編喝的可是懷念的童趣和回憶呢~\nP S. 三太子生日 指定必買\n※食品級無毒塑膠材質，不用擔心玻璃破損，小孩子們也可以安全飲用~\n※內含彈珠請勿吞食",
        image: "image\\drinks\\MarbleSoda.PNG"
    },
    drinks5: {
        name: "津津蘆筍汁",
        price: "NT$30",
        originalPrice: "NT$60",
        volume:20,
        description:"津津蘆筍汁，採用優質蘆筍製成，生津止渴，清爽好喝，特調風味口感十足\n讓人再三回味還是津津有味！\n★蔬菜中的貴族,健康最佳選擇\n★清涼退火、生津止渴\n★增強體力、營養補給\n★再三回味,還是津津有味",
        image: "image\\drinks\\AsparagusJuice.png"
    },
    drinks6: {
        name: "冰淇淋汽水",
        price: "NT$39",
        originalPrice: "NT$78",
        volume:20,
        description:"非買不可的理由:童年的滋味！古早味懷舊飲料\n規格:500ml\n內容物成份:酸水、果糖、香料、檸檬酸\n熱量:50.0大卡/250ml",
        image: "image\\drinks\\IceCreamSoda.png"
    },
    toys1: {
        name: "太空氣球",
        price: "NT$40",
        originalPrice: "NT$80",
        volume:0,
        description:"ST安全玩具\n包裝：2瓶袋裝\n內容物：無毒醋酸乙酯\nო懷舊太空氣球\nო懷舊遊戲勾起童年回憶\nო巨大泡泡可在手上隨意把玩\nო小朋友最愛童玩，可吹很大的泡泡球",
        image: "image\\toys\\SpaceBalloon.PNG"
    },
    toys2: {
        name: "竹蜻蜓",
        price: "NT$5",
        originalPrice: "NT$10",
        volume:20,
        description:"一包2入哦~~~\n經濟實惠，戶外必備小玩具\n尺寸:飛盤直徑約13cm、推杆長約28cm\n材質:ABS 包裝:opp袋裝",
        image: "image\\toys\\hopter.PNG"
    },
    toys3: {
        name: "釣魚遊戲",
        price: "NT$80",
        originalPrice: "NT$160",
        volume:20,
        description:"1.電動磁性釣魚台，寶貝們在家裡也能體驗釣魚的樂趣\n2.親子互動，增進親情，讓寶貝們在陪伴中學習及玩樂\n3.小魚嘴巴裡有磁鐵，用釣魚竿吸起就掉到囉~\n4.鍛鍊寶寶手眼協調能力，朋友家長一起玩!\n5.可靜音，也可開啟音樂",
        image: "image\\toys\\FishingGame.PNG"
    },
    toys4: {
        name: "紅包抽抽樂",
        price: "NT$60",
        originalPrice: "NT$120",
        volume:20,
        description:"內容物：21包紅包抽抽樂1張、超值獎品一批\n適齡：八歲以上\n成分：塑膠、合金、紙類\n獎品實拍圖僅供參考，每盒/每批不盡相同\nო過年遊戲，懷舊童玩\nო滿足回憶童年的慾望\nო好玩、趣味、氣氛佳\nო過年團聚、增進彼此感情的好選擇", 
        image: "image\\toys\\draw.PNG"
    },
    toys5: {
        name: "劍玉",
        price: "NT$99",
        originalPrice: "NT$198",
        volume:20,
        description:"★規 格: 採用上等山毛櫸原木,球直徑:6cm，全長:16cm\n\n｜益智趣味的民俗童玩｜\n\n｜訓練耐心、專注力、手腳協調和反應力｜\n\n｜可以隨身攜帶，走到哪玩到哪｜\n\n｜一項合適的親子遊戲｜\n\n｜優質木料，好拿耐用不怕摔｜\n\n｜台灣製造｜",
        image: "image\\toys\\kendama.PNG"
    },
    toys6: {
        name: "戳戳樂",
        price: "NT$120",
        originalPrice: "NT$240",
        volume:20,
        description:"*一盒= 60孔入\n*懷舊古早味,懷舊童玩\n* 辦活動.團康.聚會.小朋友最愛娛樂\n* (封面圖案多款 隨機出貨.無法挑款)\n* 內附商品 (內容物：小玩具居多.無法挑款)\n* 外盒 紙盒",
        image: "image\\toys\\PokingLottery.PNG"
    },
    supplies1: {
        name: "一條根",
        price: "NT$65",
        originalPrice: "NT$130",
        volume:20,
        description:"\n容量：30g\n製造地：台灣\n成份：一條根萃取液、蘆薈凝膠、尤加利精油、薄荷精油、玫瑰精油、薰衣草精油、洋甘菊萃取液、甘油\n使用方法：一日3~數次適量\n注意事項：本產品為外用、應放置孩童伸手不及處，避免高溫陽光直射環境\n保存方法：天然乳霜，放置冰箱效果更佳（本產品只供外用，請勿食用）",
    

        image: "image\\supplies\\RootOfMoghania.PNG"
    },
    supplies2: {
        name: "不求人",
        price: "NT$30",
        originalPrice: "NT$60",
        volume:20,
        description:"竹製加長孝道不求人，癢癢撓\n1.吊把設計，好收藏，不易沾污\n2.嚴選優質竹材製成，散發淡淡竹木清香，經久耐用\n3.表面光滑處理，不扎人，可安心使用\n4.輕鬆捶打與按摩，搭配穴位更舒適\n5.商品規格:長約45cmx寬約3.5cm 厚度:約0.5CM 重量:約60~70克 材質:嚴選天然竹子\n※手工測量會稍有誤差(手工製品可能會有一些竹子的自然顏色不同以及一些自然的小缺陷)",
        image: "image\\supplies\\scratch.PNG"
    },
    supplies3: {
        name: "刮痧板",
        price: "NT$37",
        originalPrice: "NT$74",
        volume:20,
        description:"塑形V臉：使用刮痧板內凹處，由下巴往耳根方向刮拭，力度輕柔，10-15次\n拉提緊緻:去除法令紋，使用刮痧板由法令紋向耳根方向刮拭，力度輕柔，次數10-15次\n淡化抬頭紋：使用刮痧板由額頭中央向兩邊刮拭，力度輕柔，10-15次\n肩頸放鬆：使用刮痧板由肩頸向兩邊刮拭，可稍加用力\n後背刮痧：使用刮痧板由後背肩頸部向背下部刮痧，可稍加用力，出痧快\n摁壓點穴：使用刮痧板尖角處，對準穴位揉壓，力度輕柔",
        image: "image\\supplies\\SxrapingBoard.PNG"
    },
    supplies4: {
        name: "花露水",
        price: "NT$55",
        originalPrice: "NT$110",
        volume:20,
        description:"【成分特點】\n．百年品牌，台灣製造\n．含有近72%食用級酒精\n．使用國際IFRA認證的進口高級香精\n．接受度最高的玫瑰與茉莉花香\n\n【經典特色】\n．令人記憶深刻的經典綠色瓶身\n．接受度最高的玫瑰與茉莉花香\n．粉紅小女孩雙手攏蓬裙，融合復古與經典\n．特殊瓶口設計，每次撒約1-2ml，不易浪費\n\n適合中小坪數空間使用",
        image: "image\\supplies\\FloridaWater.PNG"
    },
    supplies5: {
        name: "腳底按摩器",
        price: "NT$150",
        originalPrice: "NT$300",
        volume:20,
        description:"．材質：橡膠木、金屬\n．尺寸：六排輪約長32、寬26.5、高6.5cm\n\n弧面款人體工學設計直接於腳底接觸齒輪來回滾動\n達到腳底穴道指壓按摩，不管在看電視、工作、書房....\n台灣橡膠木製造\n天然木材製作每支的顏色、紋路、皆有些微差異出貨以實品為主\n使用方式：將按摩器平放地面，人坐穩於椅子上，\n將雙腳腳掌置於滾輪上來回滾動，以達按摩之效\n\n【 商品特點 】\n坐著也可按摩，雙腳踏上按摩器即可按摩腳底板，辦公室、居家紓壓必備\n底部有防滑設計，使用過程中不易滑動\n原木製，獨一無二的木紋及好質感",
       
        image: "image\\supplies\\FootMassager.PNG"
    },
    supplies6: {
        name: "雞毛撢子",
        price: "NT$89",
        originalPrice: "NT$178",
        volume:20,
        description:"|商品說明|\n★純雞毛製作\n★可用於汽車、家庭打掃清潔\n★去除附著於車身上的黃砂、花粉、灰塵、微塵等的撢子\n★收納在車廂內，想用時即可使用，非常方便\n\n|使用方式|\n★請勿在車身濕濡時使用\n★直接輕拍或擦拭使用\n\n|注意事項|\n★請勿靠近火源\n★使用完後，放置通風處即可\n\n|溫馨提示|\n★尺寸多少有誤差，實際規格以出貨商品為主\n※包裝運送過程中有時難免碰撞導致包裝不完整，敬請見諒",

        image: "image\\supplies\\FeatherDust.PNG"
    },

    
};

function toggleDropdown() {
    var dropdown = document.getElementById("dropdown-menu");
    dropdown.classList.toggle("show"); // 切換顯示或隱藏
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

// 獲取 URL 中的商品 ID
const params = new URLSearchParams(window.location.search);
const productId = params.get('id');

// 顯示對應商品的詳細信息
if (productId && products[productId]) {
    const product = products[productId];
    document.getElementById('detailImage').src = product.image;
    document.getElementById('detailName').textContent = product.name;
    document.getElementById('detailPrice').textContent = product.price;
    document.querySelector('.original-price').textContent = product.originalPrice;
    document.getElementById('detailVolume').textContent = product.volume;
    document.getElementById('detailDescription').textContent=product.description;
} else {
    document.querySelector('.product-detail').innerHTML = '<p>商品資訊不存在</p>';
}


// 初始化導覽列愛心數量
function updateWishlistCount() {
    let heartCount = parseInt(localStorage.getItem('heartCount') || 0);  // 讀取現有的收藏数量，若没有则默认为 0
    document.getElementById('wishlist-count').textContent = heartCount;
}

// 當 DOM 加載完成後執行
document.addEventListener("DOMContentLoaded", () => {
    // 更新導覽列的愛心數量
    updateWishlistCount();  // 读取并更新页面中的收藏数量
    
    const wishlistButton = document.getElementById('product-wishlist-btn');
    const heartIcon = document.getElementById('product-heart-icon');
    let wishlist = JSON.parse(localStorage.getItem("wishlist")) || [];

    // 初始化收藏狀態
    let isFavorited = localStorage.getItem(`isFavorited_${productId}`) === 'true';
    heartIcon.innerHTML = isFavorited ? '&#10084;' : '&#9825;';
    heartIcon.style.color = isFavorited ? 'red' : '#ccc';

    // 點擊收藏按鈕
    wishlistButton.addEventListener('click', () => {
        isFavorited = !isFavorited;
        heartIcon.innerHTML = isFavorited ? '&#10084;' : '&#9825;';
        heartIcon.style.color = isFavorited ? 'red' : '#ccc';

        // 更新 localStorage
        localStorage.setItem(`isFavorited_${productId}`, isFavorited);

        // 更新導覽列的愛心數量
        let heartCount = parseInt(localStorage.getItem('heartCount') || 0);

        // 判斷此商品是否在收藏中，並更新數量
        if (isFavorited) {
            heartCount++;
        } else {
            heartCount = heartCount > 0 ? heartCount - 1 : 0;
        }

        localStorage.setItem('heartCount', heartCount);
        updateWishlistCount();  // 更新導覽列顯示

        if (isFavorited) {
            // 添加到收藏清單
            wishlist.push({
                id: parseInt(productId),
                name: products[productId].name,
                price: products[productId].price,
                image: products[productId].image,
            });
        } else {
            // 從收藏清單移除
            wishlist = wishlist.filter(item => item.id !== parseInt(productId));
        }

        // 更新 localStorage
        localStorage.setItem("wishlist", JSON.stringify(wishlist));
    });

    const addToCartButton = document.getElementById("add-to-cart");
    const cartCount = document.getElementById("cart-count");
    const quantitySelect = document.getElementById("quantity");

    const customAlert = document.getElementById("custom-alert");
    const alertMessage = document.getElementById("alert-message");
    const closeAlert = document.getElementById("close-alert");
    const overlay = document.getElementById("overlay");
    const shareIcon = document.getElementById("share-icon");
    const shareOptions = document.getElementById("share-options");

    // 隱藏分享選項
    shareOptions.style.display = "none";
    // 初始化購物車數量
    const updateCartCount = () => {
        const cartItems = JSON.parse(localStorage.getItem("cartItems")) || [];
        const totalQuantity = cartItems.reduce((sum, item) => sum + item.quantity, 0);
        cartCount.textContent = totalQuantity;
    };

    // 更新購物車數量
    updateCartCount();

    // 點擊加入購物車
    addToCartButton.addEventListener("click", () => {
        const cartItems = JSON.parse(localStorage.getItem("cartItems")) || [];

        // 讀取選定數量
        const selectedQuantity = parseInt(quantitySelect.value, 10);

        // 檢查購物車中是否已存在該商品
        const existingItemIndex = cartItems.findIndex((item) => item.id === parseInt(productId));

        if (existingItemIndex !== -1) {
            // 商品已存在，更新數量
            cartItems[existingItemIndex].quantity += selectedQuantity;
        } else {
            // 商品不存在，新增商品
            const newItem = {
                id: parseInt(productId), // 使用商品 ID
                name: products[productId].name,
                price: parseInt(products[productId].price.replace("NT$", ""), 10),
                quantity: selectedQuantity,
                image: products[productId].image // 保存圖片路徑
            };
            cartItems.push(newItem);
        }

        // 儲存到 LocalStorage
        localStorage.setItem("cartItems", JSON.stringify(cartItems));

        // 更新購物車數量
        updateCartCount();

        // 顯示自定義模態窗口
        alertMessage.textContent = `商品已加入購物車！數量：${selectedQuantity}`;
        customAlert.style.display = "block";
        overlay.style.display = "block";
    });

    // 關閉模態窗口
    closeAlert.addEventListener("click", () => {
        customAlert.style.display = "none";
        overlay.style.display = "none";
    });

    // 點擊分享器圖標顯示/隱藏選項
    shareIcon.addEventListener("click", () => {
        if (shareOptions.style.display === "none" || !shareOptions.style.display) {
            shareOptions.style.display = "block";
        } else {
            shareOptions.style.display = "none";
        }
    });

    // 點擊其他區域時隱藏分享選項
    document.addEventListener("click", (event) => {
        if (!shareIcon.contains(event.target) && !shareOptions.contains(event.target)) {
            shareOptions.style.display = "none";
        }
    });



});

document.addEventListener("DOMContentLoaded", () => {
    const productId = params.get('id'); // 獲取商品 ID
    const reviewButton = document.getElementById("submit-review"); // 提交評論按鈕
    const reviewText = document.getElementById("review"); // 評論文本框
    const reviewsList = document.getElementById("reviews-list"); // 顯示評論的區域

    // 從 localStorage 加載已有評論
    let reviews = JSON.parse(localStorage.getItem(`reviews_${productId}`)) || [];

    // 顯示評論
    const displayReviews = () => {
        reviewsList.innerHTML = ''; // 清空當前顯示的評論
        reviews.forEach((review) => {
            const reviewElement = document.createElement('div');
            reviewElement.classList.add('review');
            reviewElement.innerHTML = `
                <div class="rating">
                  <div class="star">
                    ${Array.from({ length: 5 }, (_, i) => 
                      `<iconify-icon icon="${i < review.rating ? "material-symbols:star" : "material-symbols:star-outline"}" width="24" style="color: gold;"></iconify-icon>`
                    ).join('')}
                  </div>
                </div>
                <div class="text">${review.text}</div>
            `;
            reviewsList.appendChild(reviewElement);
        });
    };

    // 初次加載頁面時顯示評論
    displayReviews();


    // 處理評論提交
    reviewButton.addEventListener("click", () => {
        const text = reviewText.value.trim(); // 獲取評論文本

        if (selectedRating && text) {
            // 創建新評論對象
            const newReview = {
                rating: selectedRating,
                text: text
            };

            // 將新評論添加到評論列表
            reviews.push(newReview);

            // 儲存更新後的評論到 localStorage
            localStorage.setItem(`reviews_${productId}`, JSON.stringify(reviews));

            // 清空評論區和星星評分
            reviewText.value = '';
            selectedRating = 0;
            starIcons.forEach((icon) => icon.setAttribute("icon", "material-symbols:star-outline"));

            // 更新顯示評論
            displayReviews();
        } else {
            alert("請填寫評分和評論內容。");
        }
    });
});
document.addEventListener("DOMContentLoaded", function () {
    const starRatings = document.querySelectorAll(".star"); // 獲取所有星星評分區域

    starRatings.forEach((starRating) => {
        const starIcons = starRating.querySelectorAll(".star-icon"); // 獲取每個評分區域內的星星
        let selectedRating = 0; // 初始化選擇的評分值

        starIcons.forEach((starIcon, index) => {
            starIcon.setAttribute("data-index", index + 1); // 設置每顆星星的索引值
            starIcon.addEventListener("click", function () {
                selectedRating = parseInt(this.getAttribute("data-index")); // 更新選擇的評分值

                // 更新星星顯示，點擊的星星之前的全填滿
                starIcons.forEach((icon, i) => {
                    icon.setAttribute(
                        "icon",
                        i < selectedRating ? "material-symbols:star" : "material-symbols:star-outline"
                    );
                });

                console.log("Selected Rating: ", selectedRating); // 查看選擇的評分
            });
        });
    });
  // 當用戶點擊提交評論按鈕時觸發
  document.getElementById('submit-review').addEventListener('click', function() {
    // 取得 textarea 元素
    var reviewText = document.getElementById('review');
    
    // 當評論框有內容時清空它
    if (reviewText.value) {
      reviewText.value = '';  // 清空評論框
    }

    // 取得所有的星星元素並重置回未選中狀態（空心星）
    var starIcons = document.querySelectorAll('.star-icon');
    starIcons.forEach(function(star) {
      star.setAttribute('icon', 'material-symbols:star-outline');  // 重置為空心星圖標

    });

    // 可以加上其他處理，比如將評論內容提交到後端等
    alert('評論已提交！');  // 這只是一個簡單的提示框，實際使用中可以替換成提交評論的代碼
  });
});
