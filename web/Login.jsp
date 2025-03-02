<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
        
        <style>
            .container-fluid{
                background-color:lightskyblue;
                margin-top:-1%;
                height:58px;
        }
        
        .nav-link{
                margin-left:20px;
                font-size: 20px;
                margin-right: 25px;
        }
        
        .mb-0{
             margin-left:15px;
             font-family:monospace;
             font-style:italic;
             font-size:25px;
             font-weight:bold;
        }
        
        .container{
                position:fixed;
                margin-top:8%;
                margin-left:33%;
                width:420px;
                height:370px;
                background:aliceblue;
                border-radius: 4%;
        }
        
        .login{
            margin-top:3%;
            margin-left:3%;
            width:320px;
            height:320px;
            position:fixed;
            
        }
        
        .btn-primary{
            width:95%;
            margin-left:2%;
        }
        
        p{
            margin-left: 2%;
        }
            
        </style>
    </head>
    
    <body>
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
      <div class="container-fluid">
      <span class="navbar-brand mb-0 h1">Fly Now</span>
      <div class="navbar-nav">
        <a class="nav-link " href="index.html">Home</a>
        <a class="nav-link" href="FlightList.jsp">Flight List</a>
        <a class="nav-link active" aria-current="page" href="Login.jsp">Login</a>
        <a class="nav-link" href="Signup.jsp">Signup</a>
      </div>
  </div>
</nav> 
        
    <div class="container">
        <form class="login" method="post" action="LoginServlet" >
           <div class="mb-3">
               <label for="exampleInputEmail1" class="form-label">Email address</label>
               <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="email" required>
           </div>
           <div class="mb-3">
               <label for="exampleInputPassword1" class="form-label">Password</label>
               <input type="password" class="form-control" id="exampleInputPassword1" name="password" required>
           </div>
           <br>
        <button type="submit" class="btn btn-primary">login</button>
           <br><br>
        <p>Don't have an account?<a href="Signup.jsp">Register here</a></p>
       </form>  
       </div>
      
    </body>
</html>
