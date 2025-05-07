<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Success</title>
         <link rel="icon" href="./logo_flight.jpg">
    </head>
    <body>
        <br>
    <center><h3>Payment has been processed.<br>Thank you<br></h3>
       <button onclick="logout()">Logout</button>
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
