// To save as "ebookshop\WEB-INF\classes\QueryServlet.java".
import java.io.*;
import java.sql.*;
import java.util.*;
// import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/addproduct")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*10,      // 10MB
                 maxRequestSize=1024*1024*50)   // 50MB
public class addproductServlet extends HttpServlet{

    
    private static final String SAVE_DIR = "product_images";

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length()-1);
            }
        }
        return "";
    }

    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        // LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

   // The doGet() runs once per HTTP GET request to this servlet.
   @Override
   public void doPost(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
      // Set the MIME type for the response message
      response.setContentType("text/html");
      // Get a output writer to write the response message into the network socket
    //   PrintWriter out = response.getWriter();
      // Print an HTML page as the output of the query
    //   List<product> searchResult = new ArrayList<>();
    //   User user = new User();
    //   boolean exist = false;
    OutputStream out = null;
    InputStream filecontent = null;
    final String path = "C:/myWebProject/tomcat/webapps/headphonesHome/product_images/";
    final Part filePart = request.getPart("file");
    final String fileName = getFileName(filePart);
      
      PreparedStatement preparedStatement = null;
      try (
         // Step 1: Allocate a database 'Connection' object
         Connection conn = DriverManager.getConnection(
               "jdbc:mysql://localhost:3306/eshop?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC",
               "myuser", "xxxx");   // For MySQL
               // The format is: "jdbc:mysql://hostname:port/databaseName", "username", "password"

         // Step 2: Allocate a 'Statement' object in the Connection
         Statement stmt = conn.createStatement();
      ) {
          // Step 3 & 4: Execute a SQL SELECT query and Process the query result
         // Retrieve the books' id. Can order more than one books.
            String sqlStr;
            // int id = request.getParameter("catID");
               // Update the qty of the table books
               // gets absolute path of the web application
        // String appPath = request.getServletContext().getRealPath("");
        // constructs path of the directory to save uploaded file
        // String appPath = request.getServletContext().getRealPath("");
        // // appPath = "localhost:9999/headphonesHome";
        // // constructs path of the directory to save uploaded file
        // String savePath = appPath + File.separator + "/product_images/";
        // String fileName="";
        // // creates the save directory if it does not exists
        // File fileSaveDir = new File(savePath);
        // if (!fileSaveDir.exists()) {
        //     fileSaveDir.mkdir();
        // }
        // for (Part part : request.getParts()) {
        //     fileName = extractFileName(part);
        //     // refines the fileName in case it is an absolute path
        //     fileName = new File(fileName).getName();
        //     part.write(fileName);
        // }
        out = new FileOutputStream(new File(path + File.separator
                + fileName));
        filecontent = filePart.getInputStream();

        int read = 0;
        final byte[] bytes = new byte[1024];

        while ((read = filecontent.read(bytes)) != -1) {
            out.write(bytes, 0, read);
        }
        
               String name = request.getParameter("productname");
               String catID = request.getParameter("catID");
               String price = request.getParameter("price");
               String qty = request.getParameter("qty");
               String description = request.getParameter("description");
               String image = request.getParameter("image");
            //    Part filePart = request.getPart("image");
            //    InputStream fileContent = filePart.getInputStream();
               sqlStr = "insert into products  (name, categoryID, price, qty, description, image) values (?, ?, ?, ?, ?, ?)" ;
               preparedStatement = conn.prepareStatement(sqlStr);
               preparedStatement.setString(1, name);
               preparedStatement.setString(2, catID);
               preparedStatement.setString(3, price);
               preparedStatement.setString(4, qty);
               preparedStatement.setString(5, description);
               preparedStatement.setString(6, fileName);
               
               preparedStatement.executeUpdate();
            //    sqlStr = "select * from user where email='"+email +"' AND password ='"+password+"'" ;
            //    ResultSet rset = stmt.executeQuery(sqlStr);  // Send the query to the server
 
            //    // Create a transaction record
            //    if (rset.next()) {
            //        if (rset.getString("id")!=null) {
            //         exist = true;
            //         user.setID(rset.getString("id"));
            //         user.setRole(rset.getString("role"));
            //         user.setName(rset.getString("name"));
            //         user.setEmail(rset.getString("email"));
            //         user.setPhone(rset.getString("phone"));
            //         user.setPassword(rset.getString("password"));
            //        }
            //    }
               
                //    out.println("<option value='"+rset.getString("id")+"'>"+rset.getString("name")+"</option>");
             
      } catch(Exception ex) {
         ex.printStackTrace();
      }  // Step 5: Close conn and stmt - Done automatically by try-with-resources (JDK 7)
    //   if (exist) {
    //     request.getSession().setAttribute("user", (Object)user);
    //     if (user.getRole().equals("admin")) {
    //         response.sendRedirect(this.getServletContext().getContextPath() +"/admin.jsp");
    //     }
    //     else {
    //         response.sendRedirect(this.getServletContext().getContextPath() +"/cart.jsp");
    //     }
        
    //   }
    //   else {
    //     request.getSession().setAttribute("user", null);
    //     request.getSession().setAttribute("customermessage", "registration error, pls try again later");
    //     response.sendRedirect(this.getServletContext().getContextPath() +"/signup.jsp");
    //   }
    request.getSession().setAttribute("customermessage", "A new product is added");
    response.sendRedirect(this.getServletContext().getContextPath() +"/admin.jsp");
      
 
      out.close();
   }
}