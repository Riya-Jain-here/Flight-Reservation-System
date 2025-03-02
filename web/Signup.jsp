<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Signup</title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
    <style>
        
        .container-fluid{
                background-color:lightskyblue;
                margin-top:-1%;
                height:56px;
        }
        
        .contain{
                position: fixed;
                margin-top:45%;
                margin-left:35%;
                width:420px;
                height:510px;
                background:aliceblue;
                border-radius: 4%;     
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
        
        .reg{
            margin-top:1%;
            margin-left:3%;
            width:320px;
            height:320px;
            position: fixed;
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
        <a class="nav-link"  href="index.html">Home</a>
        <a class="nav-link" href="FlightList.jsp">Flight List</a>
        <a class="nav-link" href="Login.jsp">Login</a>
        <a class="nav-link active" aria-current="page" href="Signup.jsp">Signup</a>
      </div>
      </div>
        </<nav>
            
        <div class="contain">
            <form class="reg" method="post" action="RegistrationServlet" >
               
               <div class="mb-3">
               <label for="formGroupExampleInput" class="form-label">Username</label>
               <input type="text" class="form-control" id="formGroupExampleInput" name="uname" required>
                </div>
           <div class="mb-3">
               <label for="exampleInputEmail1" class="form-label">Email</label>
               <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="email" required >
           </div>
               
               <div class="mb-3">
               <label for="exampleInputPhoneNumber" class="form-label">Contact Number</label>
               <input type="tel" class="form-control" id="exampleInputPhoneNumber" name="cno" required>
           </div>
               
           <div class="mb-3">
               <label for="exampleInputPassword1" class="form-label">Create Password</label>
               <input type="password" class="form-control" id="exampleInputPassword1" name="password" required>
               <label for="exampleInputPassword1" class="form-label">Note:Please create password carefully.</label>
           </div>
           <br>
           <button type="submit" class="btn btn-primary">Create Account</button>
           <br><br>
           <p>Already have an account?<a href="Login.jsp">Login here</a></p>
       </form>  
        </div>

    </body>
</html>
