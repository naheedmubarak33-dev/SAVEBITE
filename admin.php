<?php
// ONE-TIME SCRIPT — run this once in the browser to create your admin account,
// then DELETE this file for security.
include 'config/db.php';

$full_name = 'Admin';
$email     = 'admin@savebite.com';
$password  = 'admin123'; // change this after first login

$check = mysqli_query($conn, "SELECT id FROM users WHERE email='$email'");
if (mysqli_num_rows($check) > 0) {
    die("Admin account already exists with this email. You can log in, or delete this file.");
}

$hashed = password_hash($password, PASSWORD_DEFAULT);
mysqli_query($conn, "INSERT INTO users (role, full_name, email, password, status) VALUES ('admin', '$full_name', '$email', '$hashed', 'active')");

echo "Admin account created!<br>Email: $email<br>Password: $password<br><br>Now delete this file (create_admin.php) for security, then log in from login.html.";
?>