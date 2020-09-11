<%@page import="pack.*"%>
<%@page import="java.util.List"%>
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
        <%
        String message = (String)session.getAttribute("customermessage");
    %>
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
                                  System.out.println(user.getRole());
                                  if (!user.getRole().equals("admin")) {
                                    response.sendRedirect("login.jsp");
                                  }
                                  %>
                              
                                <a class="navbar-item">
                                        
                                    </a>
                                <a class="navbar-item">
                                        Profile
                                    </a>
                                <hr class="navbar-divider">
                                <div class="navbar-item">
                                    <a href="LogoutServlet">Logout</a>
                                </div>
                                <%
                              } else {
                                response.sendRedirect("login.jsp");
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
        <!-- END NAV -->
        <div class="container">
            <div class="columns">
                <div class="column is-3 ">
                    <aside class="menu is-hidden-mobile">
                        <p class="menu-label">
                            General
                        </p>
                        <ul class="menu-list">
                            <li><a class="is-active">Dashboard</a></li>
                            <li><a>Customers</a></li>
                            <li><a>Other</a></li>
                        </ul>
                        <p class="menu-label">
                            Administration
                        </p>
                        <ul class="menu-list">
                            <li><a>Team Settings</a></li>
                            <li>
                                <a>Manage Your Team</a>
                                <ul>
                                    <li><a>Members</a></li>
                                    <li><a>Plugins</a></li>
                                    <li><a>Add a member</a></li>
                                    <li><a>Remove a member</a></li>
                                </ul>
                            </li>
                            <li><a>Invitations</a></li>
                            <li><a>Cloud Storage Environment Settings</a></li>
                            <li><a>Authentication</a></li>
                            <li><a>Payments</a></li>
                        </ul>
                        <p class="menu-label">
                            Transactions
                        </p>
                        <ul class="menu-list">
                            <li><a>Payments</a></li>
                            <li><a>Transfers</a></li>
                            <li><a>Balance</a></li>
                            <li><a>Reports</a></li>
                        </ul>
                    </aside>
                </div>
                <div class="column is-9">
                    <section class="hero is-info welcome is-small">
                        <div class="hero-body">
                            <div class="container">
                                <h1 class="title">
                                    Hello, Admin.
                                </h1>
                                <h2 class="subtitle">
                                    I hope you are having a great day!
                                </h2>
                            </div>
                        </div>
                    </section>
                    <section class="info-tiles">
                        <div class="tile is-ancestor has-text-centered">
                            <div class="tile is-parent">
                                <article class="tile is-child box">
                                    <p class="title">439k</p>
                                    <p class="subtitle">Users</p>
                                </article>
                            </div>
                            <div class="tile is-parent">
                                <article class="tile is-child box">
                                    <p class="title">59k</p>
                                    <p class="subtitle">Products</p>
                                </article>
                            </div>
                            <div class="tile is-parent">
                                <article class="tile is-child box">
                                    <p class="title">3.4k</p>
                                    <p class="subtitle">Open Orders</p>
                                </article>
                            </div>
                            <div class="tile is-parent">
                                <article class="tile is-child box">
                                    <p class="title">19</p>
                                    <p class="subtitle">Exceptions</p>
                                </article>
                            </div>
                        </div>
                    </section>
                    <div class="columns">
                        <div class="column is-12">
                            <div class="card events-card">
                                <header class="card-header">
                                    <p class="card-header-title">
                                        Add new product
                                    </p>
                                    <a href="#" class="card-header-icon" aria-label="more options">
                      <span class="icon">
                        <i class="fa fa-angle-down" aria-hidden="true"></i>
                      </span>
                    </a>
                                </header>
                                
                    <form action="addproduct" method="POST" enctype = "multipart/form-data">
                        <div class="card">
                        <div class="field">
                            <label class="label">Product Name</label>
                            <div class="control">
                              <input class="input" name="productname" type="text" placeholder="Text input" required>
                            </div>
                          </div>

                          <div class="field">
                            <label class="label">Category</label>
                            <div class="control">
                                <select class="input" id='category' name="catID">
                                  </select>
                            </div>
                          </div>

                          
                          
                          <div class="field">
                            <label class="label">Price</label>
                            <div class="control ">
                              <input class="input is-success" type="text" placeholder="Text input" name="price" required>
                              
                            </div>
                          </div>
                          
                          <div class="field">
                            <label class="label">Qty</label>
                            <div class="control">
                              <input class="input" name="qty" type="number" min="1" required>
                            
                              <span class="icon is-small is-right">
                                <i class="fas fa-exclamation-triangle"></i>
                              </span>
                            </div>
                          </div>
                          
                          <div class="file has-name field">
                            <label class="label">Image</label>
                            <div class="control">
                            <label class="file-label">
                              <input class="file-input" type="file" name="file" required>
                              <span class="file-cta">
                                <span class="file-icon">
                                  <i class="fas fa-upload"></i>
                                </span>
                                <span class="file-label">
                                  Choose a file…
                                </span>
                              </span>
                              <span class="file-name">
                                Screen Shot 2017-07-29 at 15.54.25.png
                              </span>
                            </label>
                        </div>
                          </div>

                          <div class="field">
                            <label class="label">Description</label>
                            <div class="control">
                              <textarea class="textarea" name="description" placeholder="Textarea"></textarea>
                            </div>
                          </div>
                          
                          
                          <div class="field is-grouped">
                            <div class="control">
                              <button class="button is-link">Submit</button>
                            </div>
                            <div class="control">
                              <button class="button is-link is-light">Cancel</button>
                            </div>
                          </div>

                          
                        </div>
                    </form>
                        
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script async type="text/javascript" src="../js/bulma.js"></script>
        <script type="text/javascript">
            var msg = "<%=message%>";
            console.log(msg);
            if (msg == undefined || msg == null || msg == "null") {
                
            }
            else {
                alert(msg);
            }
            msg = null;
            
        </script>
                
        <hr/>
        <script type="text/javascript" src="lib/main.js"></script>
        <%
        session.setAttribute("customermessage", null);
    %>
    </body>
</html>