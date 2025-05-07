<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Signup</title>
         <link rel="icon" href="./logo_flight.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
         <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        
        <style>

            body{
                background-image: url("Backg.webp");
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: 100% 100%;
            }

            .container-fluid{
                background-color:#3399ff;
                margin-top:-1%;
                height:75px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }

            .nav-link{
                margin-left:5px;
                font-size: 23px;
                margin-right: 30px;
            }

            .mb-0{
                margin-left:60px;
                font-family:monospace;
                font-style:italic;
                font-size:30px;
                font-weight:bold;
            }

            .navbar-nav{
                margin-right: 30px;
            }

            .logo-img {
                height: 60px;
                width: 60px;
                margin-right: 10px;
                vertical-align: middle;
                background: blue;
                mix-blend-mode:multiply;
                opacity: 0.9;
                border-radius: 100%;
                object-fit: cover;
            }


            .container-form{
                font-family: 'Poppins', sans-serif;
                display: flex;
                justify-content: center;
                padding-top: 100px;
                align-items: center;
                min-height: calc(100vh - 75px - 180px);
            }

            .reg{
                width: 400px;
                padding: 30px;
                background-color: rgba(255, 255, 255, 0.85); 
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            }



            .btn-primary{
                width:95%;
                margin-left:2%;
            }

            p{
                margin-left: 2%;
            }

            footer {
                position: relative;
                bottom: 0;
                width: 100%;
            }
            
    </style>
    </head>
    
    <body> 
      <nav class="navbar navbar-expand-lg fixed-top">
      <div class="container-fluid">
      <span class="navbar-brand mb-0 h1">
           <img src="logo_flight.jpg" alt="Logo" class="logo-img">
          Fly Now</span>
      <div class="navbar-nav">
        <a class="nav-link"  href="index.html">Home</a>
         <a class="nav-link" href="ContactUs.jsp">Contact Us</a>
        <a class="nav-link" href="FlightList.jsp">Flights</a>
        <a class="nav-link" href="Login.jsp">Login</a>
        <a class="nav-link active" aria-current="page" href="Signup.jsp">Signup</a>
        
      </div>
      </div>
        </nav>
            
        <div class="container-form">
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
            
            
        <footer class="bg-light text-center text-lg-start mt-5">
    <div class="container p-4">
        <div class="row">
            <!-- About -->
            <div class="col-lg-4 col-md-6 mb-4 mb-md-0">
                <h5 class="text-uppercase">Fly Now</h5>
                <p>
                    Your trusted partner for safe and affordable flight bookings across India and beyond.
                </p>
            </div>

            <!-- Useful Links -->
            <div class="col-lg-4 col-md-6 mb-4 mb-md-0">
                <h5 class="text-uppercase">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Quick Links</h5>
                <ul class="list-unstyled mb-0">
                    <li><a href="index.html" class="text-primary text-decoration-none fw-normal">Home</a></li>
                    <li><a href="FlightList.jsp" class="text-primary text-decoration-none fw-normal">Flights</a></li>
                    <li><a href="Login.jsp" class="text-primary text-decoration-none fw-normal">Login</a></li>
                    <li><a href="Signup.jsp" class="text-primary text-decoration-none fw-normal">Signup</a></li>
                    <li><a href="ContactUs.jsp" class="text-primary text-decoration-none fw-normal">Contact Us</a></li>
                </ul>
            </div>

            <!-- Contact Info -->
            <div class="col-lg-4 col-md-12 mb-4 mb-md-0">
                <h5 class="text-uppercase">Contact</h5>
                <p><i class="bi bi-envelope"></i> support@flynow.com</p>
                <p><i class="bi bi-phone"></i> +91 99999xxxxx</p>
                <p><i class="bi bi-geo-alt"></i> Delhi, India</p>
            </div>
        </div>
    </div>

    <div class="text-center p-3 bg-primary text-white">
        © 2025 Fly Now | All rights reserved
    </div>
</footer>

    </body>
</html>
