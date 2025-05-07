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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">

        <style>

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
            
            .option-box {
                width: 350px;
                height: 150px;
                background-color: #f8f9fa;
                border-radius: 15px;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                transition: transform 0.3s ease, background-color 0.3s ease;
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 20px;
            }

            .option-box:hover {
                background-color: #e0f0ff;
                transform: translateY(-5px);
            }

            .option-box a {
                text-decoration: none;
                font-size: 22px;
                color: #0056b3;
                font-weight: 500;
                font-family: 'Poppins', sans-serif;
            }

        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg fixed-top">
            <div class="container-fluid">
                <span class="navbar-brand mb-0 h1">
                    <img src="logo_flight.jpg" alt="Logo" class="logo-img">
                    Fly Now</span>
                <button onclick="logout()"class="logout-btn" >Logout</button>
            </div>
        </nav>

        <div class="d-flex justify-content-center align-items-center flex-wrap" style="margin-top: 150px;">
            <div class="option-box">
                <a href="AddFlight.jsp"><i class="bi bi-plus-circle"></i> Add Flight Details</a>
            </div>
            <div class="option-box">
                <a href="BookedList.jsp"><i class="bi bi-journal-text"></i> Check Booking Status</a>
            </div>
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

    <script>
        function logout() {
            sessionStorage.clear();
            localStorage.clear();
            window.location.href = "LogoutServlet";
        }
    </script>
</body>
</html>
