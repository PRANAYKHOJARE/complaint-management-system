<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, javax.servlet.annotation.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upload Complaint Image</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            margin-bottom: 20px;
            font-weight: bold;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .form-control-file {
            padding: 10px;
            border-radius: 5px;
        }
        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center">Upload Your Complaint Image</h2>

    <% 
        Integer userId = (Integer) session.getAttribute("id");
        if (userId == null) {
            out.println("<script>alert('Please log in to submit a complaint.'); window.location.href='User_Login.jsp';</script>");
            return;
        }

        if (request.getMethod().equalsIgnoreCase("POST")) {
            Part filePart = request.getPart("fileUpload"); // Retrieves the file

            if (filePart == null || filePart.getSize() == 0) {
                out.println("<script>alert('No file uploaded or file is empty. Please select a file.'); window.history.back();</script>");
                return;
            }

            String mimeType = filePart.getContentType();
            if (!mimeType.startsWith("image/")) {
                out.println("<script>alert('Only image files are allowed.'); window.history.back();</script>");
                return;
            }

            String fileName = "";
            String contentDisposition = filePart.getHeader("content-disposition");
            for (String item : contentDisposition.split(";")) {
                if (item.trim().startsWith("filename")) {
                    fileName = item.substring(item.indexOf("=") + 2, item.length() - 1);
                    break;
                }
            }

            String uploadDir = application.getRealPath("/") + "WebContent/avi";
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
            File file = new File(dir, uniqueFileName);

            try {
                filePart.write(file.getAbsolutePath());
            } catch (IOException e) {
                out.println("<script>alert('Error saving the file: " + e.getMessage() + ".'); window.history.back();</script>");
                return;
            }

            String filePathInDB = "avi/" + uniqueFileName; // relative path for DB

            Connection con = null;
            PreparedStatement pst = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_complaint_management_system", "root", "root");

                String query = "INSERT INTO AVI (register_id, complaint_type, file_path) VALUES (?, ?, ?)";
                pst = con.prepareStatement(query);
                pst.setInt(1, userId);
                pst.setString(2, "image");
                pst.setString(3, filePathInDB);

                int result = pst.executeUpdate();
                if (result > 0) {
                    out.println("<script>alert('Image Complaint Submitted successfully!'); window.location.href='User_Dashboard.jsp';</script>");
                } else {
                    out.println("<script>alert('Failed to submit complaint.'); window.history.back();</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
            } finally {
                try {
                    if (pst != null) pst.close();
                    if (con != null) con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    %>

    <form action="UploadImage.jsp" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="fileUpload">Upload Image:</label>
            <input type="file" class="form-control-file" id="fileUpload" name="fileUpload" accept="image/*" required>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Submit Complaint</button>
    </form>
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>
