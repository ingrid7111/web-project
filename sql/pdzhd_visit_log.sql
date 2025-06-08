CREATE TABLE visit_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ip_address VARCHAR(255),
  visit_date DATE,
  user_agent TEXT
);
