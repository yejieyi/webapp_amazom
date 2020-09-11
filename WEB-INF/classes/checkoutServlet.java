
// To save as "ebookshop\WEB-INF\classes\QueryServlet.java".
import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/checkout")
public class checkoutServlet extends HttpServlet{

   // The doGet() runs once per HTTP GET request to this servlet.
   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
      // Set the MIME type for the response message
      response.setContentType("text/html");
      // Get a output writer to write the response message into the network socket
      PrintWriter out = response.getWriter();
      // Print an HTML page as the output of the query
    //   List<product> searchResult = (List<product>) request.getSession().getAttribute("searchResult");
    //   List<product> cart = new ArrayList<>();
      if (request.getSession().getAttribute("user")==null) {
          //do something
          request.getSession().setAttribute("toCheck", "value");
          response.sendRedirect(this.getServletContext().getContextPath() +"/login.jsp");
      } else {

        User user = (User) request.getSession().getAttribute("user");
        List<product> cart = (List<product>) request.getSession().getAttribute("cart");
        String orderid;
        ArrayList<product> order = new ArrayList<>();
        boolean hasOrder = false;


        
      
      
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
                sqlStr = "insert into orders (userid) values ("+user.getID()+")" ;
                stmt.executeUpdate(sqlStr);
                sqlStr = "select * from orders where userid="+user.getID()+ " order by id desc" ;
               System.out.println(sqlStr);
               ResultSet rset = stmt.executeQuery(sqlStr);  // Send the query to the server
               rset.next();
               orderid = rset.getString("id");
               sqlStr = "insert into orderdetails  (orderid, productid, qty) values ";
               int i = 0;
            //    product item;
                    for (product p : cart) {
                        sqlStr += "("+orderid+", "+p.getID()+", "+p.getQty()+")";
                        if(i++ == cart.size() - 1){
                            // Last iteration
                        }
                        else {
                            sqlStr += ", ";
                        }
                }

                stmt.executeUpdate(sqlStr);
                for (product p: cart) {
                  sqlStr = "UPDATE products SET qty = qty - "+p.getQty()+" WHERE id = " + p.getID();
                  stmt.executeUpdate(sqlStr);
                }
               // Create a transaction record
            //    while(rset.next()) {
            //        product p = new product();
            //        p.setID(rset.getString("id"));
            //        p.setPrice(rset.getString("price"));
            //        p.setQty(rset.getString("qty"));
            //        p.setName(rset.getString("name"));
            //        p.setDescription(rset.getString("description"));
            //        p.setImage(rset.getString("image"));
            //        searchResult.add(p);
            //     //    out.println("<option value='"+rset.getString("id")+"'>"+rset.getString("name")+"</option>");
            //    }

            sqlStr = "select * from orders, orderdetails, products where orders.id = orderdetails.orderid and orderdetails.productid = products.id and userid ="+user.getID();
                System.out.println(sqlStr);
                rset = stmt.executeQuery(sqlStr);
                // if (rset.next()) {
                //     if (rset.getString("orderid")!=null) {
                //         hasOrder = true;
                //         p.setID(rset.getString("productid"));
                //         p.setPrice(rset.getString("price"));
                //         p.setQty(rset.getString("orderdetails.qty"));
                //         p.setName(rset.getString("name"));
                //         p.setDescription(rset.getString("description"));
                //         p.setImage(rset.getString("image"));
                //         p.setCatID(rset.getString("categoryID"));
                //         p.setDate(rset.getString("orderdate"));
                //         order.add(p);
                //         orderid = rset.getString("orderid");
                //     }
                    
                // }
                while (rset.next()) {

                    hasOrder = true;
                    product p = new product();
                    System.out.println(rset.getString("orderid"));
                    System.out.println(orderid);
                   p.setID(rset.getString("productid"));
                   p.setPrice(rset.getString("price"));
                   p.setQty(rset.getString("orderdetails.qty"));
                   p.setName(rset.getString("name"));
                   p.setDescription(rset.getString("description"));
                   p.setImage(rset.getString("image"));
                   p.setCatID(rset.getString("categoryID"));
                   p.setDate(rset.getString("orderdate"));
                   order.add(p);
                }
             
      } catch(Exception ex) {
         ex.printStackTrace();
      }  // Step 5: Close conn and stmt - Done automatically by try-with-resources (JDK 7)
    //   request.getSession().setAttribute("productID", request.getParameter("id"));
    request.getSession().setAttribute("cart", null);
    request.getSession().setAttribute("toCheck", null);
    response.sendRedirect(this.getServletContext().getContextPath() +"/order.jsp");
    if (hasOrder) {
      request.getSession().setAttribute("orders", (Object)order);
  }
 
      out.close();
    }
   }
}