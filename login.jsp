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
          <div class="hero-body">
            <div class="container has-text-centered">
                <div class="column is-4 is-offset-4">
                    <h3 class="title has-text-black">Login</h3>
                    <hr class="login-hr">
                    <p class="subtitle has-text-black">Please login to proceed.</p>
                    <div class="box">
                        <figure class="avatar">
                            <img src="https://placehold.it/128x128">
                        </figure>
                        <form method="GET" action="login">
                            <div class="field">
                                <div class="control">
                                    <input name="email" class="input is-large" type="email" placeholder="Your Email" autofocus="">
                                </div>
                            </div>

                            <div class="field">
                                <div class="control">
                                    <input name="password" class="input is-large" type="password" placeholder="Your Password">
                                </div>
                            </div>
                            <div class="field">
                                <label class="checkbox">
                  <input type="checkbox">
                  Remember me
                </label>
                            </div>
                            <button class="button is-block is-info is-large is-fullwidth">Login <i class="fa fa-sign-in" aria-hidden="true"></i></button>
                        </form>
                    </div>
                    <p class="has-text-grey">
                        <a href="signup.jsp">Sign Up</a> &nbsp;·&nbsp;
                        <a href="../">Forgot Password</a> &nbsp;·&nbsp;
                        <a href="../">Need Help?</a>
                    </p>
                </div>
            </div>
        </div>
          
        
        <hr/>
        <script type="text/javascript" src="lib/main.js"></script>
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
    </body>
    <%
        session.setAttribute("customermessage", null);
    %>
</html>