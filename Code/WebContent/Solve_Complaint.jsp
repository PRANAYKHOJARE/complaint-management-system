<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Kaiadmin - Resolved Complaints</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no" />
    <link rel="icon" href="assets/img/kaiadmin/favicon.ico" type="image/x-icon" />
    
    <!-- CSS Files -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/plugins.min.css" />
    <link rel="stylesheet" href="assets/css/kaiadmin.min.css" />
    <link rel="stylesheet" href="assets/css/demo.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <style>
        .nav-item {
            margin-bottom: 15px;
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
                   
                    <li class="nav-item">
                        <a href="View_All_complaint.jsp"><i class="fas fa-desktop"></i><p>View Complaints</p></a>
                    </li>
                    
                    <li class="nav-item active">
                        <a href="Solve_Complaint.jsp"><i class="fas fa-check-circle"></i><p>Solved Complaints</p></a>
                    </li>
                      <li class="nav-item"><a href="View_Feedback.jsp"><i class="fas fa-comments"></i><p>View Students Feedback</p></a></li>
                   <li class="nav-item "><a href="ViewImages.jsp"><i class="fas fa-camera"></i><p>View Image Complaints</p></a></li>
                   
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
                <div class="page-inner">
                    <div class="d-flex align-items-left flex-column flex-md-row pt-2 pb-4">
                        <div>
                            <h3 class="fw-bold mb-3">Solved Complaints</h3>
                            <h6 class="op-7 mb-2">List of Complaints Marked as Resolved</h6>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Solved Complaints List</h4>
                                </div>
                                <div class="card-body">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                             
                                                <th>Issue Type</th>
                                                <th>Description</th>
                                                <th>Requested Action</th>
                                             
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                            // Database connection and fetching data
                                            Connection con = null;
                                            Statement stmt = null;
                                            ResultSet rs = null;

                                            try {
                                                Class.forName("com.mysql.jdbc.Driver"); // Update if necessary
                                                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_complaint_management_system", "root", "root");
                                                stmt = con.createStatement();
                                                // Modify the query to only fetch resolved complaints
                                                rs = stmt.executeQuery("SELECT * FROM complaints WHERE action = 1");

                                                while (rs.next()) {
                                                    int uid = rs.getInt("uid");
                                                    String name = rs.getString("name");
                                                    String email = rs.getString("email");
                                                    String issueType = rs.getString("issue_type");
                                                    String description = rs.getString("description");
                                                    String requestedAction = rs.getString("requested_action");
                                                    int registerId = rs.getInt("register_id");
                                            %>
                                                    <tr>
                                                      
                                                        <td><%= issueType %></td>
                                                        <td><%= description != null ? description : "N/A" %></td>
                                                        <td><%= requestedAction %></td>
                                                       
                                                    </tr>
                                            <%
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            } finally {
                                                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                                try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                                                try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                                            }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Core JS Files -->
    <script src="assets/js/core/jquery-3.7.1.min.js"></script>
    <script src="assets/js/core/popper.min.js"></script>
    <script src="assets/js/core/bootstrap.min.js"></script>
    <!-- Other scripts -->
</body>
</html>
