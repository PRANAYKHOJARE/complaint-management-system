<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Uploaded Images</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/plugins.min.css">
    <link rel="stylesheet" href="assets/css/kaiadmin.min.css">
    <link rel="stylesheet" href="assets/css/demo.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
    
     .nav-item {
            margin-bottom: 15px;
        }
        .image-thumbnail {
            max-width: 150px; /* Set a maximum width for the image */
            max-height: 150px; /* Set a maximum height for the image */
            object-fit: cover; /* Ensures the image covers the given dimensions */
        }
        .card {
            margin: 20px; /* Margin around each card */
        }
        .image-container {
            display: flex; /* Use flexbox for layout */
            flex-wrap: wrap; /* Allow wrapping of items */
            justify-content: center; /* Center items */
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <div class="sidebar" data-background-color="dark">
            <div class="sidebar-content">
                <ul class="nav nav-secondary">
                    <li class="nav-item">
                        <a href="Admin_Dashboard.jsp"><i class="fas fa-home"></i><p>Dashboard</p></a>
                    </li>
                         <li class="nav-section">
                        <span class="sidebar-mini-icon">
                          <i class="fa fa-ellipsis-h"></i>
                        </span>
                        <h4 class="text-section">Components</h4>
                    </li>
                    <li class="nav-item">
                        <a href="Latest_Complaint.jsp"><i class="fas fa-th-list"></i><p>Latest Complaints</p></a>
                    </li>
                    <li class="nav-item">
                        <a href="Pending_Complaint.jsp"><i class="fas fa-pen-square"></i><p>Pending Complaints</p></a>
                    </li>
                    <li class="nav-item ">
                        <a href="View_All_complaint.jsp"><i class="fas fa-desktop"></i><p>View Complaints</p></a>
                    </li>
                    <li class="nav-item">
                        <a href="Solve_Complaint.jsp"><i class="fas fa-check-circle"></i><p>Solved Complaints</p></a>
                    </li>
                      <li class="nav-item"><a href="View_Feedback.jsp"><i class="fas fa-comments"></i><p>View Students Feedback</p></a></li>
                    <li class="nav-item active"><a href="ViewImages.jsp"><i class="fas fa-camera"></i><p>View Image Complaints</p></a></li>
                   
                     <li class="nav-item">
                        <a href="index.jsp"><i class="nav nav-collapse"></i><p>LOGOUT</p></a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="main-panel">
            <div class="main-header">
                <nav class="navbar navbar-header navbar-expand-lg border-bottom">
                    <div class="container-fluid">
                        <ul class="navbar-nav topbar-nav ms-md-auto align-items-center">
                            <!-- User dropdown -->
                        </ul>
                    </div>
                </nav>
            </div>

            <div class="container">
                <h2>Uploaded Complaint Images</h2>

                <div class="image-container">
                    <%
                        String dbURL = "jdbc:mysql://localhost:3306/student_complaint_management_system";
                        String dbUser = "root";
                        String dbPass = "root";

                        Connection con = null;
                        PreparedStatement pst = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection(dbURL, dbUser, dbPass);
                            String query = "SELECT file_path FROM AVI"; // Adjust table name as necessary
                            pst = con.prepareStatement(query);
                            rs = pst.executeQuery();

                            while (rs.next()) {
                                String filePath = rs.getString("file_path");
                                String fullPath = request.getContextPath() + "/" + filePath;
                    %>
                                <div class="card">
                                    <img src="<%= fullPath %>" class="image-thumbnail" alt="Uploaded Image">
                                    <div class="card-body">
                                        <p class="card-text">Image Path: <%= filePath %></p>
                                    </div>
                                </div>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (pst != null) pst.close();
                                if (con != null) con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <script src="assets/js/core/jquery-3.7.1.min.js"></script>
    <script src="assets/js/core/popper.min.js"></script>
    <script src="assets/js/core/bootstrap.min.js"></script>
    <!-- Other scripts -->
</body>
</html>
