<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>About Us</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.nav-item.active .nav-link {
        border-bottom: 2px solid white; /* Color and thickness of the underline */
    }

</style>
</head>
<body class="main-layout">

    <!-- Header -->
    <header style="background-color: #343a40;"> <!-- Darker background color -->
        <div class="header">
            <div class="container-fluid">
                <div class="row d_flex">
                    <div class="col-md-2 col-sm-3 col logo_section">
                        <div class="full">
                            <div class="center-desk">
                                <div class="logo">
                                    <a href="index.jsp"><img src="images/logo.png" alt="#" /></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8 col-sm-9">
                        <nav class="navigation navbar navbar-expand-md navbar-dark">
                            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample04" aria-controls="navbarsExample04" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarsExample04">
                                <ul class="navbar-nav mr-auto">
                                    <li class="nav-item ">
                                        <a class="nav-link" href="index.jsp">Home</a>
                                    </li>
                                    <li class="nav-item active">
                                        <a class="nav-link" href="about.jsp">About</a>
                                    </li>
                                   
                                    <li class="nav-item">
                                        <a class="nav-link" href="Registration.jsp">Registration</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="User_Login.jsp">User Login</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="Admin_Login.jsp">Admin Login</a>
                                    </li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- End Header -->

    <!-- Top Header Section -->
    <div class="top-header" style="background-color: #f8f9fa; padding: 10px;">
        <div class="container text-center">
            <h1></h1>
            <p></p>
        </div>
    </div>
    <!-- End Top Header Section -->
    <br/>
    <br/>
    <br/>
    <br/>
    <!-- Paragraph Section -->
    <div class="container" style="margin-top: 20px;">
        <h2>About Us</h2>
        <p>Welcome to the Student Complaint Management System. Our goal is to provide a platform for students to voice their concerns and ensure they are addressed efficiently. We prioritize transparency and communication between students and administration, creating a supportive environment for everyone.</p>
    </div>

    <div class="container" style="margin-top: 20px;">
        <div class="row">
            <div class="col-md-6">
                <img src="images/h2.gif" alt="About Us" class="img-fluid">
            </div>
            <div class="col-md-6">
                <h2>Our Mission</h2>
                <p>To empower students by providing a clear channel for feedback and resolutions, fostering a better educational experience.</p>
                <br/><br/>
                 <h2>Our Team</h2>
        <div class="member">
            <h4>[1] Arpita Baitule</h4>
        </div>
        <div class="member">
            <h4>[2] Darshika Tehare</h4>
        </div>
        <div class="member">
            <h4>[3] Anuksha Dhope</h4>
        </div>
        <div class="member">
            <h4>[4] Pranay Khojare</h4>
        </div>
            </div>
        </div>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/custom.js"></script>
</body>
</html>
