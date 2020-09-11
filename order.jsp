<%@page import="pack.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Amazom</title>
    <link rel="stylesheet" href="css/main.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script>
        function loadCat(){
    
        $.ajax({
           url : 'loadCat',
           type: "GET",
           async: false,
           success:function(response){
            var $select = $("#category");
            $select.append(response);
            console.log(response);
           },
           error: function (event) {
    
               console.log("ERROR: ", event);
           }
        });
    }
    </script>
    </head>
    <body onload="loadCat()">
        <nav class="navbar">
            <div class="container">
                <div class="navbar-brand">
                  <i class="fab fa-amazon"></i>
                  <span class="icon"><i class="fab fa-amazon"></i></span>
                    <span class="navbar-burger burger" data-target="navbarMenu">
                            <span></span>
                    <span></span>
                    <span></span>
                    </span>
                </div>
                <div id="navbarMenu" class="navbar-menu">
                    <div class="navbar-end">
                        <a href="index.jsp" class="navbar-item is-active">
                                Home
                            </a>
                        <a href="cart.jsp" class="navbar-item">
                                Cart
                            </a>
                        <div class="navbar-item has-dropdown is-hoverable">
                            <a class="navbar-link">
                                    Account
                                </a>
                            <div class="navbar-dropdown">
                              <%
                                User user;
                                if (session.getAttribute("user") != null) {
                                  user = (User)session.getAttribute("user");
                                  %>
                              
                                <a class="navbar-item">
                                        
                                    </a>
                                <a class="navbar-item">
                                        Profile
                                    </a>
                                <a href="order.jsp" class="navbar-item">
                                        Orders
                                    </a>
                                <hr class="navbar-divider">
                                <div class="navbar-item">
                                    <a href="LogoutServlet">Logout</a>
                                </div>
                                <%
                              } else {
                            %>
                            <a href="login.jsp" class="navbar-item">
                              Log in
                          </a>
                            <%
                              }
                            %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
        <section class="hero is-small is-primary">
            <div class="hero-body">
              <div class="container">
                <div class="columns">
                  <div class="column is-8-desktop is-offset-2-desktop">
                    <h1 class="title is-2 is-spaced">
                      Amazom
                    </h1>
                    <h2 class="subtitle is-4">
                        Welcome to <strong>Amazom</strong>.com
                        <br>
                        You can find <strong>anything</strong> on Amazon here with a cheaper price.
                        <br>
                        <strong>Amazom</strong>, the cheaper amazon
                    </h2>
                  </div>
                </div>
              </div>
            </div>
          </section>
          <form method="GET" action="search">
            <div class="field has-addons">
              <p class="control">
                <span class="select">
                  <select id='category' name="catID">
                    <option value="all">All</option>
                  </select>
                </span>
              </p>
              <p class="control is-expanded">
                <input class="input" type="text" name="searchText">
              </p>
              <p class="control">
                <input class="button" type="submit" value="Search">
                </input>
              </p>
            </div>
          </form>
        <p>
            
        </p>
            <!--Results-->
            
            
                <%
                    double totalPrice = 0.0;
                    String formato;
                    
                    ArrayList<ArrayList<product>> orders;
                    ArrayList<product> order = (ArrayList<product>) session.getAttribute("orders");
                    
                    if (order == null || order.size()<=0){
                %>
               <p class="subtitle"> Your have no previous orders</p>
               <br>
                <%
                    }else
                    { 
                        
                    %>
                    <p class="subtitle">Your orders:</p>
                    <br>
                    <br>
                    <%
                   
                    for (product p:order) {
                            String imageLocation = "http://localhost:9999/headphonesHome/product_images/" + p.getImage();
                            totalPrice += Double.parseDouble(p.getPrice())*(Integer.parseInt(p.getQty()));
                            formato = String.format("%.2f", totalPrice);
                %>
                <div class="card tile" style="margin: 25px 80px;padding: 0 40px ;">
                    <div class="card-image" style="margin: 10px;">
                      <figure class="image is-128x128">
                        <img class ="image is-128x128" src="<%=imageLocation%>" alt="Placeholder image">
                      </figure>
                    </div>
                    <div class="card-content">
                        <div class="media-content">
                            <p class="title is-4">$<%=p.getPrice()%></p>
                          <a href="detail?id=<%=p.getID()%>&catid=<%=p.getCatID()%>" class="subtitle is-6"><%=p.getName()%></a>
                          <p>Qty: <%=p.getQty()%></p>
                          <p>Order time: <%=p.getDate()%></p>
                        </div>
                      </div>
                  
                    </div>
                </div>
                <%
                    }
                    %>
                 <%
                    
                    %>
                 <br>
                 <div><p class="title is-4">Total: $<%=totalPrice%></p></div>
                 <!-- <form action="checkout" method="GET"><div class="control">
                    <button type="submit" class="button is-primary">Check out</button>
                  </div></form> -->
                  <%
                }
             %>
                
        <hr/>
        <script type="text/javascript" src="lib/main.js"></script>
    </body>
</html>