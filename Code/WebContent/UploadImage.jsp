<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, javax.servlet.annotation.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upload Complaint Image</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2>Upload Your Complaint Image</h2>

    <% 
        Integer userId = (Integer) session.getAttribute("id");
        if (userId == null) {
            out.println("<script>alert('Please log in to submit a complaint.'); window.location.href='User_Login.jsp';</script>");
            return;
        }

        int maxFileSize = 5000 * 1024;
        int maxMemSize = 5000 * 1024;
        String filePath = application.getRealPath("/") + "AVI/"; // Update to AVI folder

        // Verify the content type
        String contentType = request.getContentType();
        if (contentType != null && contentType.indexOf("multipart/form-data") >= 0) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(maxMemSize);
            factory.setRepository(new File(filePath));
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setSizeMax(maxFileSize);

            try {
                List<FileItem> fileItems = upload.parseRequest(request);
                Iterator<FileItem> i = fileItems.iterator();

                while (i.hasNext()) {
                    FileItem fi = i.next();
                    if (!fi.isFormField()) {
                        String fileName = fi.getName();
                        if (fileName != null && !fileName.isEmpty()) {
                            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                            File file = new File(filePath, uniqueFileName);
                            fi.write(file);

                            String filePathInDB = "AVI/" + uniqueFileName; // Update relative path for DB

                            // Database connection and insertion
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
                                    out.println("<script>alert('Image stored successfully in the database!'); window.location.href='User_Dashboard.jsp';</script>");
                                } else {
                                    out.println("<script>alert('Failed to submit complaint.'); window.history.back();</script>");
                                }
                            } catch (Exception e) {
                                out.println("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
                            } finally {
                                if (pst != null) pst.close();
                                if (con != null) con.close();
                            }
                        } else {
                            out.println("<script>alert('No file uploaded or file is empty.'); window.history.back();</script>");
                        }
                    }
                }
            } catch (Exception ex) {
                out.println("<script>alert('Error: " + ex.getMessage() + "'); window.history.back();</script>");
            }
        }
    %>

    <form action="UploadImage.jsp" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="fileUpload">Upload Image:</label>
            <input type="file" class="form-control-file" id="fileUpload" name="fileUpload" accept="image/*" required>
        </div>
        <button type="submit" class="btn btn-primary">Submit Complaint</button>
    </form>
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>
