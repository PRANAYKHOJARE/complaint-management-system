<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Basic -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <!-- Site Metas -->
    <title>Login</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Style CSS -->
    <link rel="stylesheet" href="css/style.css">
    <!-- Responsive -->
    <link rel="stylesheet" href="css/responsive.css">
    <!-- Awesome Font Family -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            background-image: url('images/v3.jpg'); /* Path to your background image */
            background-size: cover; /* Cover the entire viewport */
            background-position: bottom; /* Position the image at the bottom */
            background-repeat: no-repeat; /* Prevent image repetition */
            height: 100vh; /* Ensure the body takes the full height of the viewport */
        }
        .login-container {
            border: 2px solid black; /* Border color */
            border-radius: 10px; /* Rounded corners */
            padding: 20px; /* Padding inside the box */
            background-color: rgba(255, 255, 255, 0.9); /* Background color for the box */
            max-width: 500px; /* Set a maximum width for the box */
            margin: 190px 20px 0 auto; /* Top margin and center it on the right */
            position: relative; /* Position relative for proper alignment */
        }
        .nav-item.active .nav-link {
        border-bottom: 2px solid white; /* Color and thickness of the underline */
    }
    </style>
</head>
<!-- Body -->
<body class="main-layout">
    
    <!-- Header -->
    <header>
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
                                    <li class="nav-item">
                                        <a class="nav-link" href="index.jsp">Home</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="about.jsp">About</a>
                                    </li>
                                   
                                    <li class="nav-item">
                                        <a class="nav-link" href="Registration.jsp">Registration</a>
                                    </li>
                                    <li class="nav-item active">
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

    <!-- Space Between Header and Login Box -->
    <div style="height: 50px;"></div>

    <!-- Login Form Section -->
    <div class="container login-container">
        <h2 class="text-center">Login</h2>
        <form method="POST">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div><br/>
            <button type="submit" class="btn btn-primary btn-block" style="background-color:white; color: black;" >Login</button>
        </form><br/>
        <p class="signup-link">Don't have an account? <a href="Registration.jsp">Register here</a></p>
    </div>
    <!-- End Login Form Section -->

    <script>
        <% 
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                // Get form data
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                Connection con = null;
                PreparedStatement pst = null;
                ResultSet rs = null;

                try {
                    // Load MySQL JDBC driver
                    Class.forName("com.mysql.jdbc.Driver");

                    // Establish database connection
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_complaint_management_system", "root", "root");

                    // SQL query to check if user exists
                    String query = "SELECT * FROM registration WHERE email=? AND password=?";
                    pst = con.prepareStatement(query);

                    // Set parameters for PreparedStatement
                    pst.setString(1, email);
                    pst.setString(2, password);

                    // Execute the query
                    rs = pst.executeQuery();

                    // Check if user exists
                    if (rs.next()) {
                        // Storing the user UID in session
                        int userId = rs.getInt("id");
                        session.setAttribute("id", userId); // Store UID in session

                        out.println("<script>alert('Login Successful!'); </script>");
                        response.sendRedirect("User_Dashboard.jsp"); // Redirect to the dashboard or home page after successful login
                    } else {
                        out.println("<script>alert('Invalid email or password.');</script>");
                    }
                } catch (Exception e) {
                    out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
                    e.printStackTrace();
                } finally {
                    // Close database resources
                    try {
                        if (pst != null) pst.close();
                        if (rs != null) rs.close();
                        if (con != null) con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </script>

    <!-- Javascript files -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/custom.js"></script>
</body>
</html>
