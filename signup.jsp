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
    <style>
        .column {
	padding-top: 0 !important;
	padding-bottom: 0 !important;
}
.row-one {
	padding-top: 13px;
}
form .field {
	margin: auto;
	max-width: 740px;
}
    </style>
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
    function checkPhone() {
        var $phone = $("#phone");
        var re=/[6|8|9]\d{7}$/;
        if (!re.test(phone.value)) {
            alert("Invalid Phone number");
            return false;
        }
    }
    </script>
    <script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
  
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
          <div id="app">
            <div class="section">
              <div class="container">
                <div class="media is-pulled-right">
                  <div class="media-content"><span class="has-text-center">Connect With:</span><br/>
                    <div class="field is-grouped">
                      <div class="control">
                        <div class="g-signin2"></div>
                      </div>
                      <div class="control">
                        <button class="button google"><span class="google-icon icon"><i class="fab fa-google"></i></span>
                          <p>Sign In</p>
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="title">Sign Up</div>
                <div class="subtitle">With Your Email</div>
                <form id="register-form" onsubmit="return checkPhone()" action="signup">
                  <div class="field">
                    <label class="label" for="username">Username</label>
                    <div class="control has-icons-left">
                      <input class="input" required type="text" placeholder="Username" name="username"/><span class="icon is-left"><i class="fa">user</i></span>
                    </div>
                    <label class="label" for="email" >Email</label>
                    <div class="control has-icons-left">
                      <input required class="input" type="email" placeholder="Email" name="email"/><span class="icon is-left"><i class="fa">envelope-square</i></span>
                    </div>
                    <div class="columns row-one">
                      <div class="column">
                        <label class="label" for="Phone">Phone No</label>
                        <div class="control has-icons-left">
                            <input id="phone" required class="input" type="tel" placeholder="Phone" name="phone"/><span class="icon is-left"><i class="fas fa-mobile-alt"></i></span>
                          </div>
                      </div>
                    </div>
                    <div class="columns">
                      <div class="column">
                        <label class="label" for="password">Password</label>
                        <div class="control has-icons-left">
                          <input required class="input" type="password" placeholder="Password" name="password"/><span class="icon is-left"><i class="fa">key</i></span>
                        </div>
                      </div>
                      <div class="column">
                        <label class="label" for="retypePassword">Re-Type Password</label>
                        <div class="control has-icons-left">
                          <input required class="input" type="password" placeholder="Confirm Password" name="retypePassword"/><span class="icon is-left"><i class="fa">lock</i></span>
                        </div>
                      </div>
                    </div>
                    <div class="field is-grouped">
                      <div class="control">
                        <button class="button is-medium"><a href="login.jsp">Login</a></button>
                      </div>
                      <div class="control">
                        <button class="button is-primary is-medium" type="submit">Register</button>
                      </div>
                    </div>
                  </div>
                </form>
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