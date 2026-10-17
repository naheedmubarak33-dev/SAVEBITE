-- Run ye phpMyAdmin ke SQL tab mein (savebite database select karke)
-- Naya naam "notification_settings" rakha hai taake asal "settings" table
-- (jo site-wide admin config ke liye hai) se conflict na ho.

CREATE TABLE IF NOT EXISTS notification_settings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL UNIQUE,
  email_notifications TINYINT(1) DEFAULT 1,
  sms_notifications TINYINT(1) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

ALTER TABLE users ADD COLUMN status ENUM('active','blocked') DEFAULT 'active';