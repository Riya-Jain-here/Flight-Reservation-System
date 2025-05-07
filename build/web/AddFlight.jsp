<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Flights Details</title>
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

            footer {
                position: relative;
                bottom: 0;
                width: 100%;
            }

            .condiv{
                background-color: white;
                border-radius: 30px;
                width:80%;
                height:80%;
                margin: 70px auto 50px auto;
                font-weight:bold;
                font-family:'Poppins', sans-serif;
                font-size: 20px;
                box-shadow:  4px 4px 8px white;
            }

            .form-container{
                display:grid;
                grid-template-columns: auto auto auto auto;
                align-items: center;
                gap: 60px;
                padding:30px;
            }

            input{
                border-radius: 30px;
                width:100%;
                height:35px;
                display: block;
                padding-left: 25px;
                font-size: 20px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                border: 1px solid #ccc;
                outline: none;
            }

            .btn-form{
                top:87%;
                width:130px;
                height:50px;
                border-radius: 10px;
                font-size: 100%;
                color: blue;
                background-color:white;
                border: 1px solid blue;
                cursor: pointer;
            }

            .btn-form:hover {
                background-color: #3399ff;
                color: white;
                border-color: #3399ff;
            }

            .logout-btn {
                margin-right: 40px;
                padding: 6px 15px;
                font-size: 16px;
                background-color: #0056b3;
                border: none;
                border-radius: 4px;
                color: white;
                cursor: pointer;
            }

            .logout-btn:hover {
                background-color: #004494;
            }

        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg fixed-top">
            <div class="container-fluid">
                <span class="navbar-brand mb-0 h1">
                    <img src="logo_flight.jpg" alt="Logo" class="logo-img">
                    Fly Now</span>
                <button onclick="logout()"  class="logout-btn">Logout</button>
            </div>
        </nav> 

        <div class="container text-center mt-5">
            <br>
            <h3 class="display-5 fw-bold text-white">Add Flight Details</h3>
        </div>

        <div class="condiv">
            <form action="AddFlightServlet" method="post" class="form-container"> 
                Flight No:<input type="text" name="flightNo" class="form-control" required>
                Flight Name: <input type="text" name="flightName" class="form-control" required>
                From City: <input type="text" name="fromCity" class="form-control" required>
                Destination: <input type="text" name="destination" class="form-control" required>
                Date:<input type="date" name="date" class="form-control" required>
                Departure Time: <input type="time" name="departure_time" class="form-control" required>
                Arrival Time: <input type="time" name="arrival_time" class="form-control" required>
                Ticket Price: <input type="number" name="ticket_price" class="form-control" step="5000" required>
                No of Seats: <input type="number" name="no_of_seats" class="form-control" min="1" required><br>
                <button type="submit" class="btn-form"> Add Flight</button>
            </form>
        </div>
        <script>
            function logout() {
                sessionStorage.clear();
                localStorage.clear();
                window.location.href = "LogoutServlet";
            }
        </script>

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

                    <!-- useful links -->
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
