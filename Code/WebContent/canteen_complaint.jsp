<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- basic -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- mobile metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Canteen Complaint Form</title>
    
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
            background-image: url('images/5.jpg'); /* Replace with your image path */
            background-size: cover; /* Cover the entire body */
            background-position: center; /* Center the background */
            background-repeat: no-repeat; /* Prevent repeating */
        }

        /* Header Styles */
        .header {
            background: rgba(0, 0, 0, 0.7);
            padding: 20px 20px; /* Increased top and bottom padding for height */
            display: flex; /* Flexbox for horizontal layout */
            align-items: center; /* Center items vertically */
            justify-content: space-between; /* Space between logo and nav */
        }

        .header .logo img {
            width: 100px;
        }

        /* Navigation Styles */
        nav .navbar-nav {
            display: flex; /* Make nav items horizontal */
            list-style: none;
            padding: 0;
            margin: 0;
        }

        nav .navbar-nav .nav-link {
            color: #fff;
            padding: 10px 15px; /* Add some padding for better spacing */
            text-decoration: none;
        }

        /* Form Styles */
        .container {
            max-width: 550px;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8); /* White background with transparency */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.6); /* Subtle shadow */
            margin: 50px auto; /* Center horizontally with auto margins and add some top margin */
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2rem;
            color: #333;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold; /* Bold labels */
        }

        .form-control {
            width: 100%; /* Full-width input fields */
            padding: 10px; /* Padding for inputs */
            border: 1px solid #ccc; /* Light border */
            border-radius: 4px; /* Rounded input fields */
            box-sizing: border-box; /* Include padding in width */
        }

        .form-control:focus {
            border-color: #007bff; /* Highlight border on focus */
            outline: none; /* Remove default outline */
        }

        .btn {
            background-color: #007bff; /* Primary button color */
            color: white; /* Text color */
            padding: 10px 20px; /* Button padding */
            border: none; /* Remove default border */
            border-radius: 4px; /* Rounded button */
            cursor: pointer; /* Pointer cursor on hover */
            font-size: 1rem; /* Button text size */
            transition: background-color 0.3s; /* Transition for hover effect */
        }

        .btn:hover {
            background-color: #0056b3; /* Darker shade on hover */
        }
    </style>
</head>

<body>
    <!-- Header -->
    <header>
        <div class="header">
            <div class="logo">
                <a href="index.jsp"><img src="images/logo.png" alt="#" /></a>
            </div>
            <nav class="navbar navbar-expand-md navbar-dark">
                <ul class="navbar-nav">
                    <li class="nav-item active"><a class="nav-link" href="User_Dashboard.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="My_Complaint.jsp">My Complaint</a></li>
                    <li class="nav-item"><a class="nav-link" href="My_Solve_Complaint.jsp">Solved Complaint</a></li>
                    <li class="nav-item"><a class="nav-link" href="My_Sending_complaint.jsp">Pending Complaint</a></li>
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Logout</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <!-- end header -->

    <!-- Canteen Complaint Form Section -->
    <div class="container">
        <h2 class="form-header">Canteen Complaint Form</h2>
        <form  method="POST">
            <div class="form-group">
                <label for="name">Your Name:</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Your Email:</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
           
            <div class="form-group">
                <label for="issue">Type of Issue:</label>
                <select class="form-control" id="issue" name="issue_type" required>
                    <option value="">Choose...</option>
                    <option value="quality">Quality of Food</option>
                    <option value="hygiene">Hygiene Issues</option>
                    <option value="service">Service Issues</option>
                    <option value="menu">Menu Availability</option>
                    <option value="pricing">Pricing Issues</option>
                    <option value="other">Other</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="description">Description:</label>
                <input type="text" class="form-control" id="description" name="description" required>
            </div>
            <div class="form-group">
                <label for="requested_action">requested_action:</label>
                <textarea class="form-control" id="requested_action" name="requested_action" rows="5" required></textarea>
            </div>
            <button type="submit" class="btn">Submit Complaint</button>
        </form>
    </div>
    <!-- end Canteen Complaint Form Section -->





<% 
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String issue_type = request.getParameter("issue_type");
    String description = request.getParameter("description");
    String requested_action = request.getParameter("requested_action");
    
    Integer register_id = (Integer) session.getAttribute("id"); // Get registration ID from session
    
    
    

    Connection con = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_complaint_management_system", "root", "root");

        String query = "INSERT INTO complaints(name, email, issue_type,description, requested_action, register_id) VALUES (?, ?,?, ?, ?,?)";
        pst = con.prepareStatement(query);
        
        pst.setString(1, name);
        pst.setString(2, email);
        pst.setString(3, issue_type);
        pst.setString(4, description);
        pst.setString(5, requested_action);
       
        pst.setInt(6, register_id); 
       
        int result = pst.executeUpdate();
        
        if (result > 0) {
            out.println("<script>alert('form submit Successful!');</script>");
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


    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
