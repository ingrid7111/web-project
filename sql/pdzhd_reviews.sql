SELECT * FROM pdzhd.reviews;
INSERT INTO reviews (username, product_id, rating, comment, admin_reply, review_time)
VALUES ('testuser', 'P123', 4, '這是一筆測試評論內容，測試排版與回覆功能。', NULL, NOW());
