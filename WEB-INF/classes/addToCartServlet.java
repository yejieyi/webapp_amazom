
// To save as "ebookshop\WEB-INF\classes\QueryServlet.java".
import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/addtoCart")
public class addToCartServlet extends HttpServlet{

   // The doGet() runs once per HTTP GET request to this servlet.
   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
      // Set the MIME type for the response message
      response.setContentType("text/html");
      // Get a output writer to write the response message into the network socket
      PrintWriter out = response.getWriter();
      // Print an HTML page as the output of the query
      List<product> searchResult = (List<product>) request.getSession().getAttribute("searchResult");
      List<product> cart = new ArrayList<>();
      if (request.getSession().getAttribute("cart")!=null) {
          cart = (List<product>) request.getSession().getAttribute("cart");
      }
      String id = request.getParameter("id");
      String qty = request.getParameter("qty");
      product item;
      for (product p : searchResult) {
          if (p.getID().equals(id)) {
              item = p;
              item.setQty(qty);
              cart.add(item);
          }
      }
      
    //   try (
    //      // Step 1: Allocate a database 'Connection' object
    //      Connection conn = DriverManager.getConnection(
    //            "jdbc:mysql://localhost:3306/eshop?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC",
    //            "myuser", "xxxx");   // For MySQL
    //            // The format is: "jdbc:mysql://hostname:port/databaseName", "username", "password"

    //      // Step 2: Allocate a 'Statement' object in the Connection
    //      Statement stmt = conn.createStatement();
    //   ) {
    //       // Step 3 & 4: Execute a SQL SELECT query and Process the query result
    //      // Retrieve the books' id. Can order more than one books.
    //         String sqlStr;
    //         // int id = request.getParameter("catID");
    //            // Update the qty of the table books
    //             sqlStr = "select * from products where categoryID = " + request.getParameter("catid") +" and id != "+request.getParameter("id") ;
               
    //            System.out.println(sqlStr);
    //            ResultSet rset = stmt.executeQuery(sqlStr);  // Send the query to the server
 
    //            // Create a transaction record
    //            while(rset.next()) {
    //                product p = new product();
    //                p.setID(rset.getString("id"));
    //                p.setPrice(rset.getString("price"));
    //                p.setQty(rset.getString("qty"));
    //                p.setName(rset.getString("name"));
    //                p.setDescription(rset.getString("description"));
    //                p.setImage(rset.getString("image"));
    //                searchResult.add(p);
    //             //    out.println("<option value='"+rset.getString("id")+"'>"+rset.getString("name")+"</option>");
    //            }
             
    //   } catch(Exception ex) {
    //      ex.printStackTrace();
    //   }  // Step 5: Close conn and stmt - Done automatically by try-with-resources (JDK 7)
    //   request.getSession().setAttribute("productID", request.getParameter("id"));
      request.getSession().setAttribute("cart", (Object)cart);
        response.sendRedirect(this.getServletContext().getContextPath() +"/cart.jsp");
 
      out.close();
   }
}