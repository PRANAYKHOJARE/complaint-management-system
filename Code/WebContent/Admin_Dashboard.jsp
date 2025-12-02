<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Kaiadmin - Bootstrap 5 Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no" />
    <link rel="icon" href="assets/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <!-- CSS Files -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/plugins.min.css" />
    <link rel="stylesheet" href="assets/css/kaiadmin.min.css" />
    <link rel="stylesheet" href="assets/css/demo.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
        /* Add spacing between sidebar items */
        .nav-item {
            margin-bottom: 15px; /* Adjust the value for desired spacing */
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <!-- Sidebar -->
        <div class="sidebar" data-background-color="dark">
            <div class="sidebar-content">
                <ul class="nav nav-secondary">
                    <li class="nav-item active">
                        <a href="Admin_Dashboard.jsp"><i class="fas fa-home"></i><p>Dashboard</p></a>
                    </li>
                    <li class="nav-section">
                        <span class="sidebar-mini-icon">
                            <i class="fa fa-ellipsis-h"></i>
                        </span>
                        <h4 class="text-section">Components</h4>
                    </li>
                    <li class="nav-item"><a href="Latest_Complaint.jsp"><i class="fas fa-th-list"></i><p>Latest Complaints</p></a></li>
                    <li class="nav-item"><a href="Pending_Complaint.jsp"><i class="fas fa-pen-square"></i><p>Pending Complaints</p></a></li>
                    <li class="nav-item"><a href="View_All_complaint.jsp"><i class="fas fa-desktop"></i><p>View Complaints</p></a></li>
                    <li class="nav-item"><a href="Solve_Complaint.jsp"><i class="fas fa-check-circle"></i><p>Solved Complaints</p></a></li>
                    <li class="nav-item"><a href="View_Feedback.jsp"><i class="fas fa-comments"></i><p>View Students Feedback</p></a></li>
                    <li class="nav-item"><a href="ViewImages.jsp"><i class="fas fa-camera"></i><p>View Image Complaints</p></a></li>
                   <li class="nav-item"><a href="index.jsp"><i class="nav nav-collapse"></i><p>LOGOUT</p></a></li>
                </ul>
            </div>
        </div>
        <!-- End Sidebar -->

        <div class="main-panel">
            <div class="main-header">
                <nav class="navbar navbar-header navbar-expand-lg border-bottom">
                    <div class="container-fluid">
                        <ul class="navbar-nav topbar-nav ms-md-auto align-items-center"></ul>
                    </div>
                </nav>
            </div>

            <div class="container">
                <div class="page-inner">
                    <div class="d-flex align-items-left flex-column flex-md-row pt-2 pb-4">
                        <div>
                            <h3 class="fw-bold mb-3">Complaint Management System</h3>
                            <h6 class="op-7 mb-2">Welcome To Admin Dashboard</h6>
                        </div>
                    </div>

                    <div class="row">
                        <%
                        // Database connection and fetching data
                        Connection con = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        int latestComplaintCount = 0;
                        int pendingComplaintCount = 0;
                        int solvedComplaintCount = 0;
                        int feedbackCount = 0; // Feedback count

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_complaint_management_system", "root", "root");
                            
                            // Fetch total count of complaints
                            stmt = con.createStatement();
                            rs = stmt.executeQuery("SELECT COUNT(*) FROM complaints");
                            if (rs.next()) latestComplaintCount = rs.getInt(1);

                            // Fetch count of pending complaints
                            rs = stmt.executeQuery("SELECT COUNT(*) FROM complaints WHERE action = 0");
                            if (rs.next()) pendingComplaintCount = rs.getInt(1);
                            
                            // Fetch count of solved complaints
                            rs = stmt.executeQuery("SELECT COUNT(*) FROM complaints WHERE action = 1");
                            if (rs.next()) solvedComplaintCount = rs.getInt(1);
                            
                            // Fetch count of feedback
                            rs = stmt.executeQuery("SELECT COUNT(*) FROM feedback_form");
                            if (rs.next()) feedbackCount = rs.getInt(1);
                            
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                        %>

                        <div class="col-sm-6 col-md-3">
                            <div class="card card-stats card-round">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col-icon">
                                            <div class="icon-big text-center icon-primary bubble-shadow-small">
                                                <i class="fas fa-bullhorn"></i>
                                            </div>
                                        </div>
                                        <div class="col col-stats ms-3 ms-sm-0">
                                            <div class="numbers">
                                                <p class="card-category">Latest Complaints</p>
                                                <p class="card-title"><%= latestComplaintCount %></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-6 col-md-3">
                            <div class="card card-stats card-round">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col-icon">
                                            <div class="icon-big text-center icon-info bubble-shadow-small">
                                                <i class="fas fa-exclamation-triangle"></i>
                                            </div>
                                        </div>
                                        <div class="col col-stats ms-3 ms-sm-0">
                                            <div class="numbers">
                                                <p class="card-category">PendingComplaints</p>
                                                <p class="card-title"><%= pendingComplaintCount %></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-sm-6 col-md-3">
                            <div class="card card-stats card-round">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col-icon">
                                            <div class="icon-big text-center icon-secondary bubble-shadow-small">
                                                <i class="fas fa-eye"></i>
                                            </div>
                                        </div>
                                        <div class="col col-stats ms-3 ms-sm-0">
                                            <div class="numbers">
                                                <p class="card-category">Viewed Complaints</p>
                                                <p class="card-title"><%= latestComplaintCount %></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                           </div>  
                        </div>


                        <div class="col-sm-6 col-md-3">
                            <div class="card card-stats card-round">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col-icon">
                                            <div class="icon-big text-center icon-success bubble-shadow-small">
                                                <i class="fas fa-check-circle"></i>
                                            </div>
                                        </div>
                                        <div class="col col-stats ms-3 ms-sm-0">
                                            <div class="numbers">
                                                <p class="card-category">Solved Complaints</p>
                                                <p class="card-title"><%= solvedComplaintCount %></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                       
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-8">
                            <div class="card card-round">
                                <div class="card-header">
                                    <div class="card-head-row">
                                        <div class="card-title">User Statistics</div>
                                        <div class="card-tools">
                                            <a href="#" class="btn btn-label-success btn-round btn-sm me-2">
                                                <span class="btn-label"><i class="fa fa-pencil"></i></span>
                                                Export
                                            </a>
                                            <a href="#" class="btn btn-label-info btn-round btn-sm">
                                                <span class="btn-label"><i class="fa fa-print"></i></span>
                                                Print
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="chart-container" style="min-height: 375px">
                                        <canvas id="statisticsChart"></canvas>
                                    </div>
                                    <div id="myChartLegend"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                    <script>
                        const ctx = document.getElementById('statisticsChart').getContext('2d');
                        const statisticsChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: ['Latest Complaints', 'Pending Complaints', 'Solved Complaints', 'Feedback Count'],
                                datasets: [{
                                    label: 'Complaints Count',
                                    data: [<%= latestComplaintCount %>, <%= pendingComplaintCount %>, <%= solvedComplaintCount %>, <%= feedbackCount %>],
                                    backgroundColor: [
                                        'rgba(23, 125, 255, 0.6)',
                                        'rgba(255, 99, 132, 0.6)',
                                        'rgba(54, 162, 235, 0.6)',
                                        'rgba(255, 206, 86, 0.6)'
                                    ],
                                    borderColor: [
                                        'rgba(23, 125, 255, 1)',
                                        'rgba(255, 99, 132, 1)',
                                        'rgba(54, 162, 235, 1)',
                                        'rgba(255, 206, 86, 1)'
                                    ],
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                scales: {
                                    y: {
                                        beginAtZero: true
                                    }
                                }
                            }
                        });
                    </script>

                    <!-- Students Feedback Section -->
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card card-round">
                                <div class="card-body">
                                    <div class="card-head-row card-tools-still-right">
                                        <div class="card-title">Students Feedback</div>
                                        <div class="card-tools">
                                            <div class="dropdown">
                                                <button class="btn btn-icon btn-clean me-0" type="button" data-bs-toggle="dropdown">
                                                    <i class="fas fa-ellipsis-h"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-list py-4">
                                        <%
                                        try {
                                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_complaint_management_system", "root", "root");
                                            stmt = con.createStatement();
                                            rs = stmt.executeQuery("SELECT name, email FROM feedback_form");
                                            while (rs.next()) {
                                                String name = rs.getString("name");
                                                String email = rs.getString("email");
                                        %>
                                            <div class="item-list">
                                                <div class="avatar">
                                                    <img src="assets/img/avtar.webp" alt="..." class="avatar-img rounded-circle" />
                                                </div>
                                                <div class="info-user ms-3">
                                                    <div class="username"><%= name %></div>
                                                    <div class="status"><%= email %></div>
                                                </div>
                                                <a href="View_Feedback.jsp" class="btn btn-icon btn-link op-8 me-1">
        <i class="far fa-envelope"></i>
    </a>
      <button class="btn btn-icon btn-link btn-danger op-8"><i class="fas fa-ban"></i></button>
                                            </div>
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
                                    </div>
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
</body>
</html>
