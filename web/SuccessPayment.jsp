<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Success</title>
    </head>
    <body>
    <center><h3>Payment has been processed.<br>Thank you</h3>
        <a href="index.html">  <button onclick="logout()">Logout</button></a> 
    </center>
    
     <script>
               function logout() {
                  sessionStorage.clear(); 
                  localStorage.clear();   
                  window.location.href = "Logout.jsp"; 
                }
         </script>
    </body>
</html>
