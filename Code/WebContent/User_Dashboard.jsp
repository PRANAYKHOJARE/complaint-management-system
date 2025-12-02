<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- basic -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- mobile metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hightech</title>
    
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
            background-image: url("images/"); /* Background image */
            background-size: cover;
            background-position: center center;
            background-attachment: fixed;
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

        /* Team Header */
        .team-header {
            text-align: center;
            font-size: 2.5rem;
            color: #fff;
            margin-top: 20px;
            font-weight: bold;
        }

        /* Team Section Styles */
        .team-section {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            margin-top: 1px;
            padding: 50px;
        }

        .member {
            width: 250px;
            margin: 20px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }

        .member:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .member h2 {
            font-size: 1.5rem;
            margin: 10px 0;
            font-weight: 600;
        }

        .member img {
            width: 100px;
            height: 80px;
            border-radius: 50%;
            margin-bottom: 10px;
            display: inline-block;
            vertical-align: middle;
            margin-right: 10px;
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
            <div class="logo">
                <a href="index.jsp"><img src="images/logo.png" alt="#" /></a>
            </div>
            <nav class="navbar navbar-expand-md navbar-dark">
                <ul class="navbar-nav">
                    <li class="nav-item active"><a class="nav-link" href="User_Dashboard.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="My_Complaint.jsp">My Complaint</a></li>
                    <li class="nav-item"><a class="nav-link" href="My_Solve_Complaint.jsp">Solved Complaint</a></li>
                    <li class="nav-item"><a class="nav-link" href="My_Pending_Complaint.jsp">Pending Complaint</a></li>
                     <li class="nav-item"><a class="nav-link" href="feedback_form.jsp">Add Feedback</a></li>
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Logout</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <!-- end header -->

    <!-- User Dashboard Logic -->
    <%
        // Use the existing session object directly
        Integer userId = (Integer) session.getAttribute("id");

        if (userId == null) {
            out.println("<script>alert('Please log in to view your complaints.'); window.location.href='User_Login.jsp';</script>");
            return;
        }

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish database connection
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_complaint_management_system", "root", "root");

            // SQL query to retrieve complaints for the logged-in user
            String query = "SELECT action FROM complaints WHERE register_id = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, userId);
            rs = pst.executeQuery();

            boolean hasSolvedComplaints = false;

            while (rs.next()) {
                int action = rs.getInt("action");
                if (action == 1) {
                    hasSolvedComplaints = true;
                    break;
                }
            }

            if (hasSolvedComplaints) {
                out.println("<script>alert('Your complaint is solved.');</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        } finally {
            // Close database resources
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>

    <div class="container">
        <h2 class="team-header">Welcome to Your Dashboard</h2>
        <!-- Types of Complaint -->
        <section class="team-section">
            <a href="faculty_complaint.jsp" class="member">
                <img src="images/rn.jpg" alt="">
                <h2>Faculty</h2>
            </a>
            <a href="facility_complaint.jsp" class="member">
                <img src="images/e.webp" alt="">
                <h2>Facilities</h2>
            </a>
            <a href="canteen_complaint.jsp" class="member">
                <img src="images/ek.jpg" alt="">
                <h2>Canteen</h2>
            </a>
            <a href="library_complaint.jsp" class="member">
                <img src="images/library.jpg" alt="">
                <h2>Library</h2>
            </a>
            <a href="other_complaint.jsp" class="member">
                <img src="images/u.png" alt="">
                <h2>Other</h2>
            </a>
                       <a href="AVI.jsp" class="member">
                <img src="images/complaint2.png" alt="">
                <h2>Add Complaint for Uploading image</h2>
            </a>
        </section>
        <!-- end Types of Complaint -->
    </div>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
