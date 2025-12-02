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
            background-image: url("images/jk.jpg"); /* Background image */
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
            color: black; /* Changed to black */
            margin-top: 20px;
            font-weight: bold;
        }

        /* Table Styles */
        table {
            width: 80%; /* Full width */
            margin: 20px auto;
            padding: 8px;
            margin-top: 20px; /* Space from header */
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: rgba(0, 0, 0, 0.1);
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
                    <li class="nav-item "><a class="nav-link" href="User_Dashboard.jsp">Home</a></li>
                    <li class="nav-item active"><a class="nav-link" href="My_Complaint.jsp">My Complaint</a></li>
                    <li class="nav-item"><a class="nav-link" href="My_Solve_Complaint.jsp">Solved Complaint</a></li>
                    <li class="nav-item"><a class="nav-link" href="My_Pending_Complaint.jsp">Pending Complaint</a></li>
                       <li class="nav-item"><a class="nav-link" href="feedback_form.jsp">Add Feedback</a></li>
                  
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Logout</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <!-- end header -->
    
    <!-- My Complaints Table -->
    <div class="container">
        <h2 class="team-header">My Complaints</h2>
        <% 
            // Get the user ID from the session
            Integer userId = (Integer) session.getAttribute("id");
        %>
        <p class="user-id" style="color: black; text-align: center;">Your Registered ID: <%= userId != null ? userId : "Not logged in" %></p>
        <table class="table">
            <thead>
                <tr>
                    <th>Complaint Type</th>
                    <th>Description</th>
                    <th>Action Requested</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if (userId != null) {
                        Connection con = null;
                        PreparedStatement pst = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_complaint_management_system", "root", "root");

                            // Query for complaints by registration ID
                            String query = "SELECT issue_type, description, requested_action " +
                                           "FROM complaints WHERE register_id = ?";
                            pst = con.prepareStatement(query);
                            pst.setInt(1, userId);
                          
                            rs = pst.executeQuery();
                            
                            boolean hasComplaints = false; // Flag to check for complaints
                            while (rs.next()) {
                                hasComplaints = true; // Set flag if there are complaints
                %>
                                <tr>
                                    <td><%= rs.getString("issue_type") %></td>
                                    <td><%= rs.getString("description") != null ? rs.getString("description") : "No description provided." %></td>
                                    <td><%= rs.getString("requested_action") %></td>
                                </tr>
                <% 
                            }
                            if (!hasComplaints) {
                                out.println("<tr><td colspan='3'>No complaints found.</td></tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (pst != null) pst.close();
                                if (con != null) con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    } else {
                %>
                    <tr><td colspan="3">You are not logged in.</td></tr>
                <% 
                    } 
                %>
            </tbody>
        </table>
    </div>
    <!-- end My Complaints Table -->

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
