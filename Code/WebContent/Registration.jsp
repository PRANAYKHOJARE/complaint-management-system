<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Registration</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background-image: url('images/v4.jpg'); /* Path to your background image */
            background-size: cover; /* Cover the entire viewport */
            background-position: center; /* Center the image */
            background-repeat: no-repeat; /* Prevent image repetition */
        }
        
        .nav-item.active .nav-link {
        border-bottom: 2px solid white; /* Color and thickness of the underline */
    }
    </style>
</head>
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
                                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                                <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                                <li class="nav-item active"><a class="nav-link" href="Registration.jsp">Registration</a></li>
                                <li class="nav-item"><a class="nav-link" href="User_Login.jsp">User Login</a></li>
                                <li class="nav-item"><a class="nav-link" href="Admin_Login.jsp">Admin Login</a></li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Space Between Header and Registration Box -->
<div style="height: 50px;"></div>

<!-- Registration Form Section -->
<div class="container" style="max-width: 600px; margin-top: 100px; border: 2px solid black; border-radius: 10px; padding: 20px; background-color: rgba(255, 255, 255, 0.9);">
    <h2 class="text-center">Registration</h2>
    <form method="POST">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" class="form-control" id="username" name="name" required>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="contact">Contact:</label>
            <input type="text" class="form-control" id="contact" name="contact" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div><br/>

       <button type="submit" class="btn btn-block" style="background-color: #FFA500; color: black;">Register</button>
     </form>
       <p class="signup-link">If Already have an account? <a href="User_Login.jsp">Login here</a></p>
 

<% 
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String contact = request.getParameter("contact");
    String password = request.getParameter("password");

    Connection con = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_complaint_management_system", "root", "root");

        String query = "INSERT INTO Registration(name, email, contact, password) VALUES (?, ?, ?, ?)";
        pst = con.prepareStatement(query);
        
        pst.setString(1, name);
        pst.setString(2, email);
        pst.setString(3, contact);
        pst.setString(4, password);

        int result = pst.executeUpdate();
        
        if (result > 0) {
            out.println("<script>alert('Registration Successful!');</script>");
        } else {
            out.println("<script>alert('Error: Please try again later.');</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        e.printStackTrace();
    } finally {
        try {
            if (pst != null) pst.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>

</div>

<script src="/js/jquery.min.js"></script>
<script src="/js/bootstrap.bundle.min.js"></script>
<script src="/js/custom.js"></script>

</body>
</html>
