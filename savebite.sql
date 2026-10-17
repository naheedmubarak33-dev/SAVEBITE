CREATE DATABASE IF NOT EXISTS savebite;
USE savebite;

-- USERS (Donor, NGO, Admin sab isi table mein)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role ENUM('donor','ngo','admin') NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20) DEFAULT NULL,
    city VARCHAR(50) DEFAULT NULL,
    address VARCHAR(255) DEFAULT NULL,
    org_name VARCHAR(100) DEFAULT NULL,      -- sirf NGO ke liye
    website VARCHAR(150) DEFAULT NULL,       -- sirf NGO ke liye
    founded_year INT DEFAULT NULL,           -- sirf NGO ke liye
    status ENUM('active','blocked') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- DONATIONS (Donor post karta hai)
CREATE TABLE donations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    donor_id INT NOT NULL,
    food_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    serves INT DEFAULT 0,
    location VARCHAR(255) NOT NULL,
    expiry_time DATETIME NOT NULL,
    contact_phone VARCHAR(20) NOT NULL,
    notes TEXT,
    status ENUM('available','claimed','completed','expired','cancelled') DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (donor_id) REFERENCES users(id) ON DELETE CASCADE
);

-- REQUESTS (NGO kisi donation ko claim karti hai)
CREATE TABLE requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    donation_id INT NOT NULL,
    ngo_id INT NOT NULL,
    notes TEXT,
    status ENUM('pending','approved','rejected','completed') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (donation_id) REFERENCES donations(id) ON DELETE CASCADE,
    FOREIGN KEY (ngo_id) REFERENCES users(id) ON DELETE CASCADE
);

-- PICKUPS
CREATE TABLE pickups (
    id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT NOT NULL,
    donation_id INT NOT NULL,
    ngo_id INT NOT NULL,
    donor_id INT NOT NULL,
    volunteer_name VARCHAR(100) DEFAULT NULL,
    pickup_location VARCHAR(255) NOT NULL,
    pickup_time DATETIME NOT NULL,
    status ENUM('scheduled','in_progress','completed','cancelled') DEFAULT 'scheduled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (request_id) REFERENCES requests(id) ON DELETE CASCADE,
    FOREIGN KEY (donation_id) REFERENCES donations(id) ON DELETE CASCADE,
    FOREIGN KEY (ngo_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (donor_id) REFERENCES users(id) ON DELETE CASCADE
);

-- VOLUNTEERS (NGO manage karti hai)
CREATE TABLE volunteers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ngo_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    role VARCHAR(50) DEFAULT NULL,
    area VARCHAR(100) DEFAULT NULL,
    status ENUM('active','inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ngo_id) REFERENCES users(id) ON DELETE CASCADE
);

-- NOTIFICATIONS
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    message VARCHAR(255) NOT NULL,
    is_read TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- PLATFORM SETTINGS (Admin ke liye, ek hi row rahegi)
CREATE TABLE settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    platform_name VARCHAR(100) DEFAULT 'Save Bite',
    tagline VARCHAR(150) DEFAULT NULL,
    contact_email VARCHAR(100) DEFAULT NULL,
    contact_phone VARCHAR(20) DEFAULT NULL,
    maintenance_mode TINYINT(1) DEFAULT 0,
    registration_open TINYINT(1) DEFAULT 1
);
INSERT INTO settings (platform_name) VALUES ('Save Bite');