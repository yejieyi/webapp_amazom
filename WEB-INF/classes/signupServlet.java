// To save as "ebookshop\WEB-INF\classes\QueryServlet.java".
import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/signup")
public class signupServlet extends HttpServlet{

   // The doGet() runs once per HTTP GET request to this servlet.
   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
      // Set the MIME type for the response message
      response.setContentType("text/html");
      // Get a output writer to write the response message into the network socket
      PrintWriter out = response.getWriter();
      // Print an HTML page as the output of the query
      List<product> searchResult = new ArrayList<>();
      User user = new User();
      boolean exist = false;
      
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
               String name = request.getParameter("username");
               String email = request.getParameter("email");
               String password = request.getParameter("password");
               String phone = request.getParameter("phone");
               sqlStr = "insert into user (name, email, password, phone) values (?, ?, ?, ?)" ;
               preparedStatement = conn.prepareStatement(sqlStr);
               preparedStatement.setString(1, name);
               preparedStatement.setString(2, email);
               preparedStatement.setString(3, password);
               preparedStatement.setString(4, phone);
               
               preparedStatement.executeUpdate();
               sqlStr = "select * from user where email='"+email +"' AND password ='"+password+"'" ;
               ResultSet rset = stmt.executeQuery(sqlStr);  // Send the query to the server
 
               // Create a transaction record
               if (rset.next()) {
                   if (rset.getString("id")!=null) {
                    exist = true;
                    user.setID(rset.getString("id"));
                    user.setRole(rset.getString("role"));
                    user.setName(rset.getString("name"));
                    user.setEmail(rset.getString("email"));
                    user.setPhone(rset.getString("phone"));
                    user.setPassword(rset.getString("password"));
                   }
               }
               
                //    out.println("<option value='"+rset.getString("id")+"'>"+rset.getString("name")+"</option>");
             
      } catch(Exception ex) {
         ex.printStackTrace();
      }  // Step 5: Close conn and stmt - Done automatically by try-with-resources (JDK 7)
      if (exist) {
        request.getSession().setAttribute("user", (Object)user);
        if (user.getRole().equals("admin")) {
            response.sendRedirect(this.getServletContext().getContextPath() +"/admin.jsp");
        }
        else {
            response.sendRedirect(this.getServletContext().getContextPath() +"/cart.jsp");
        }
        
      }
      else {
        request.getSession().setAttribute("user", null);
        request.getSession().setAttribute("customermessage", "registration error, pls try again later");
        response.sendRedirect(this.getServletContext().getContextPath() +"/signup.jsp");
      }
      
 
      out.close();
   }
}