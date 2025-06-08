CREATE TABLE members (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL,
  name VARCHAR(50),
  phone VARCHAR(20),
  email VARCHAR(100),
  role ENUM('user', 'admin') DEFAULT 'user',
  register_time DATETIME DEFAULT CURRENT_TIMESTAMP
);
