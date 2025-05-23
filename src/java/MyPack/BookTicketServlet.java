package MyPack;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BookTicketServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String flight_id= request.getParameter("flight_id");
        
         if (flight_id== null || flight_id.trim().isEmpty()) {
            response.sendRedirect("FlightList.jsp?error=FlightIdMissing");
            return;
        }
         
         int flight_no = 0;
         
         try {
            flight_no = Integer.parseInt(flight_id); // Convert to integer
        } 
         catch (NumberFormatException e) {
            System.out.println("Error: Invalid flight id format - " + flight_id);
            response.sendRedirect("FlightList.jsp?error=InvalidFlightId");
            return;
        }
        
        if (session == null || session.getAttribute("user_id") == null) {
             session = request.getSession();
             
             //add line
             session.setAttribute("selected_flight_id", flight_no);
             
            response.sendRedirect("Login.jsp?fromBooking=true");
            return;
        } 
         
        try (Connection connection = DatabaseConnection.initializeDatabase()) {
            int user_id = (int) session.getAttribute("user_id");

            PreparedStatement checkStmt = connection.prepareStatement(
                    "SELECT * FROM bookedList WHERE user_id = ? AND flight_id = ? AND payment_status = 'Pending'"
            );
            checkStmt.setInt(1, user_id);
            checkStmt.setInt(2, flight_no);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Already booked but pending
                request.setAttribute("errorMessage", "You have already booked this flight. Please complete the payment.");
                request.getRequestDispatcher("Already_Booked_Tickets.jsp").forward(request, response);
            }
        
        else {
            // Redirect to BookTicket.jsp with selected flight details
            request.setAttribute("flight_no", flight_no);
            request.getRequestDispatcher("BookTicket.jsp").forward(request, response);
        }
           
    } 
        
        catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Internal server error.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer user_id = (session != null) ? (Integer) session.getAttribute("user_id") : null;
        
        
        if (user_id == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        
        int flight_id = Integer.parseInt(request.getParameter("flight_id"));
        String flightName=request.getParameter("flightName");
        String passengerName=request.getParameter("passengerName");
        String email = request.getParameter("email");
        String date=request.getParameter("date");
        int no_of_seats= Integer.parseInt(request.getParameter("no_of_seats"));
        double ticketPrice=Double.parseDouble(request.getParameter("ticketPrice"));
        
        double totalPrice = no_of_seats * ticketPrice;
       
        try {
            Connection connection = DatabaseConnection.initializeDatabase();
            
            // Check seat availability
            PreparedStatement ps1 = connection.prepareStatement("SELECT no_of_seats FROM flightList WHERE flight_id=?");
            ps1.setInt(1, flight_id);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next()) {
                int availableSeats = rs1.getInt("no_of_seats");
                if (no_of_seats > availableSeats) {
                    connection.rollback();
                    response.getWriter().println("Not enough seats available.");
                    return;
                }

            //check for user with pending status
            String checkQuery = "SELECT * FROM bookedList WHERE passenger_email=? AND flight_id=? AND payment_status = 'Pending'";
            PreparedStatement checkPs = connection.prepareStatement(checkQuery);
            checkPs.setString(1, email);
             checkPs.setInt(2, flight_id);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // Booking already exists, show error message
                request.setAttribute("errorMessage", "You have already Booked your tickets! Please proceed with payment");
                request.getRequestDispatcher("Already_Booked_Tickets.jsp").forward(request, response);
                return;
            }
            
                // Insert booking
                PreparedStatement ps2 = connection.prepareStatement(
                        "INSERT INTO bookedList (user_id, flight_id, flightName, passengerName, passenger_email, departureDate, no_of_seats, ticketPrice) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                PreparedStatement.RETURN_GENERATED_KEYS);
                ps2.setInt(1, user_id);
                ps2.setInt(2, flight_id);
                ps2.setString(3,flightName);
                ps2.setString(4, passengerName);
                ps2.setString(5, email);
                ps2.setString(6, date);
                ps2.setInt(7, no_of_seats);
                ps2.setDouble(8, totalPrice);
                
                int rows2=ps2.executeUpdate();

                int ticket_id = 0;
                 ResultSet rs2 = ps2.getGeneratedKeys();
                 if (rs2.next()) {
                 ticket_id = rs2.getInt(1); // Fetch the generated ticket_id
                 System.out.println("Generated ticket_id in BookTicketServlet: " + ticket_id);
                 }
              
                // Update available seats
                PreparedStatement ps3 = connection.prepareStatement("UPDATE flightList SET no_of_seats = no_of_seats  - ? WHERE flight_id = ?");
                ps3.setInt(1, no_of_seats);
                ps3.setInt(2, flight_id);
                int rows3=ps3.executeUpdate();
                
                request.setAttribute("bookingMessage", "Ticket booked successfully! Please proceed with payment.");
                
                RequestDispatcher dispatcher=request.getRequestDispatcher("Payment.jsp?email=" +email + "&ticket_id=" + ticket_id + "&totalPrice=" + totalPrice + "&msg=Ticket+booked+successfully!+Please+proceed+with+payment.");
                dispatcher.forward(request,response);
            }
            else {
                response.getWriter().println("BookTicket.jsp?error=FlightNotFound");
            }
            connection.close();
        } 
        catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("BookTicket.jsp?error=BookingFailed");
        }
    }
}
