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
                    <li class="nav-item active">
                        <a href="Latest_Complaint.jsp"><i class="fas fa-th-list"></i><p>Latest Complaints</p></a>
                    </li>
                    <li class="nav-item">
                        <a href="Pending_Complaint.jsp"><i class="fas fa-pen-square"></i><p>Pending Complaints</p></a>
                    </li>
                    <li class="nav-item">
                        <a href="View_All_complaint.jsp"><i class="fas fa-desktop"></i><p>View Complaints</p></a>
                    </li>
                    <li class="nav-item">
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
                            <h3 class="fw-bold mb-3">Complaint Management System</h3>
                            <h6 class="op-7 mb-2">Welcome To Admin Dashboard</h6>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Complaints List</h4>
                                </div>
                                <div class="card-body">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                              
                                                <th>Issue Type</th>
                                                <th>Description</th>
                                                <th>Requested Action</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                            // Handle form submission for updating complaints
                                            Connection con = null;
                                            PreparedStatement pst = null;

                                            try {
                                                // Establish database connection
                                                Class.forName("com.mysql.jdbc.Driver");
                                                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_complaint_management_system", "root", "root");

                                                String uidParam = request.getParameter("uid");
                                                String actionParam = request.getParameter("action");
                                                if (uidParam != null && actionParam != null) {
                                                    int uid = Integer.parseInt(uidParam);
                                                    int action = Integer.parseInt(actionParam);

                                                    // Update complaint action in the database
                                                    String updateQuery = "UPDATE complaints SET action = ? WHERE uid = ?";
                                                    pst = con.prepareStatement(updateQuery);
                                                    pst.setInt(1, action);
                                                    pst.setInt(2, uid);
                                                    pst.executeUpdate();
                                                    out.println("<script>alert('Complaint updated successfully.');</script>");
                                                }

                                                // Fetch updated complaints
                                                Statement stmt = con.createStatement();
                                                ResultSet rs = stmt.executeQuery("SELECT * FROM complaints");

                                                while (rs.next()) {
                                                    String email = rs.getString("email");
                                                    String issueType = rs.getString("issue_type");
                                                    String description = rs.getString("description");
                                                    String requestedAction = rs.getString("requested_action");
                                                    int uid = rs.getInt("uid");
                                            %>
                                                    <tr>
                                                      
                                                        <td><%= issueType %></td>
                                                        <td><%= description != null ? description : "N/A" %></td>
                                                        <td><%= requestedAction %></td>
                                                        <td>
                                                            <form method="post" style="display:inline;">
                                                                <input type="hidden" name="uid" value="<%= uid %>">
                                                                <input type="hidden" name="action" value="1"> <!-- For Resolve -->
                                                                <button type="submit" class="btn btn-success">Resolve</button>
                                                            </form>
                                                            <form method="post" style="display:inline;">
                                                                <input type="hidden" name="uid" value="<%= uid %>">
                                                                <input type="hidden" name="action" value="0"> <!-- For Pending -->
                                                                <button type="submit" class="btn btn-danger">Pending</button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                            <%
                                                }
                                                rs.close();
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            } finally {
                                                try { if (pst != null) pst.close(); } catch (SQLException e) { e.printStackTrace(); }
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
