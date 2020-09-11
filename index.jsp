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
    </footer>
    <script type="text/javascript" src="lib/main.js"></script>
  </body>
</html>
