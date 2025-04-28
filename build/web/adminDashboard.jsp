<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
        <link rel="icon" href="./logo_flight.jpg">
        <style>
       
            
        .container-fluid{
                background-color:lightskyblue;
                margin-top:-1%;
                height:58px;
        }
        
        .mb-0{
             margin-left:15px;
             font-family:monospace;
             font-style:italic;
             font-size:25px;
             font-weight:bold;
        }
        
        a{
            font-style:italic;
            font-size:25px;
            color:darkgreen;
        }
        
    </style>
    </head>
    <body>
        <nav class="navbar bg-body-tertiary">
           <div class="container-fluid">
               <span class="navbar-brand mb-0 h1">Welcome to Fly Now</span>
               <button onclick="logout()" >Logout</button>
           </div>
        </nav>
        
    <center><br><br><br><br><br><br>
        <h5><a href="AddFlight.jsp">Click here to add flight details.</a><br></h5><br><br>
       
        <h5>  <a href="BookedList.jsp">Click here to see booked tickets list.</a></h5>
    </center>  
        
         <script>
               function logout() {
                  sessionStorage.clear(); 
                  localStorage.clear();   
                  window.location.href = "LogoutServlet"; 
                }
         </script>
    </body>
</html>
