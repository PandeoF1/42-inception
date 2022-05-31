CREATE DATABASE IF NOT EXISTS wp_db_name_to_remove;
CREATE USER IF NOT EXISTS 'wp_user_to_remove'@'%' IDENTIFIED BY 'wp_password_to_remove';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user_to_remove'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'wp_password_root_to_remove';