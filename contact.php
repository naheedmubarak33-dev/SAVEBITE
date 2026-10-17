<?php
include 'config/db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $name    = trim($_POST['name']);
    $email   = trim($_POST['email']);
    $message = trim($_POST['message']);

    if ($name == "" || $email == "" || $message == "") {
        echo "<script>alert('Please fill all fields'); window.history.back();</script>";
        exit;
    }

    $sql = "INSERT INTO contact_messages (name, email, message) VALUES ('$name', '$email', '$message')";

    if (mysqli_query($conn, $sql)) {
        echo "<script>alert('Message sent successfully! We will get back to you soon.'); window.location.href='index.html';</script>";
    } else {
        echo "<script>alert('Failed to send message: " . mysqli_error($conn) . "'); window.history.back();</script>";
    }
    exit;
}
?>