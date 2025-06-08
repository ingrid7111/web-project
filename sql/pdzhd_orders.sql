-- 訂單主表
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50),
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 訂單明細
CREATE TABLE order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  price INT
);

INSERT INTO orders (username, order_date) VALUES ('testuser', NOW());
SET @orderId = LAST_INSERT_ID();
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (@orderId, 1, 1, 200);

