<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Basic -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Login</title>
    
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">

    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa; /* Light background */
            display: flex;
            flex-direction: column;
            height: 100vh; /* Full height */
        }

        /* Header Styles */
        header {
            flex: 0 0 auto; /* Don't grow */
        }

        /* Container Styles */
        .container {
            display: flex; /* Flex layout for the container */
            max-width: 800px; /* Max width for the entire container */
            width: 100%; /* Full width */
            background-color: #fff; /* White background for the form */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            margin: auto; /* Center horizontally */
            margin-top: auto; /* Push to bottom */
        }

        /* Login Form Styles */
        .login-form {
            padding: 20px; /* Padding for the form */
            flex: 1; /* Allow the form to grow */
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2rem;
            color: #333;
        }

        .form-group {
            margin-bottom: 40px;
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

        .error {
            color: red;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        /* GIF Section */
        .gif-section {
            flex: 1; /* Allow the GIF section to grow */
            display: flex; /* Flexbox for centering */
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
            background: url('images/rr.gif') no-repeat center center; /* Replace with your GIF URL */
            background-size: cover; /* Cover the section */
        }
        .nav-item.active .nav-link {
        border-bottom: 2px solid white; /* Color and thickness of the underline */
    }
    </style>
</head>

<body>
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
                                    <li class="nav-item">
                                        <a class="nav-link" href="User_Login.jsp">User Login</a>
                                    </li>
                                    <li class="nav-item active">
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

    <!-- Admin Login Form Section -->
    <div class="container">
        <div class="login-form">
            <h2 class="form-header">Admin Login</h2>
            <form method="POST">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <button type="submit" class="btn">Login</button>
            </form>

            <% 
              // Get username and password from the form
              String username = request.getParameter("username");
              String password = request.getParameter("password");

              // Check if the username and password match "admin"
              if (username != null && password != null && username.equals("admin") && password.equals("admin")) {
                // If correct, redirect to the dashboard.jsp page
                response.sendRedirect("Admin_Dashboard.jsp");
              } 
              else if (username != null && password != null) {
            %>
                <div class="error">Invalid username or password. Please try again.</div>
            <% 
              }
            %>
        </div>
        <div class="gif-section">
            <!-- Optionally, you can add an <img> tag if not using a background image -->
            <!-- <img src="images/rr.gif" alt="Your GIF" style="max-width: 100%; height: auto;" /> -->
        </div>
    </div>
    <!-- End Admin Login Form Section -->

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
