package MyPack;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddFlightServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String fromCity = request.getParameter("fromCity");
        String toCity = request.getParameter("toCity");
        String travelDate = request.getParameter("travelDate");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/frs?useSSL=false&serverTimezone=UTC", 
                "root", "your_password");

            String sql = "SELECT * FROM flightList WHERE fromCity = ? AND toCity = ? AND date = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, fromCity);
            ps.setString(2, toCity);
            ps.setString(3, travelDate);

            ResultSet rs = ps.executeQuery();
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin-top:5%;}");
            out.println("table { width: 80%; margin: auto; border-collapse: collapse; }");
            out.println("th, td { border: 1px solid black; padding: 10px; text-align: center; }");
            out.println("</style>");
            out.println("<center><h2>Available Flights</h2></center>");
            out.println("<center><table border='3'><tr><th>Flight Number</th><th>Flight Name</th><th>Departure Time</th><th>Arrival Time</th><th>Ticket Price</th></tr></center>");

            boolean found = false;
            while (rs.next()) {
                found = true;
                out.println("<tr>");
                out.println("<td>" + rs.getString("flight_No") + "</td>");
                out.println("<td>" + rs.getString("flightName") + "</td>");
                out.println("<td>" + rs.getString("departureTime") + "</td>");
                out.println("<td>" + rs.getString("arrivalTime") + "</td>");
                out.println("<td>$" + rs.getBigDecimal("ticketPrice") + "</td>");
                out.println("</tr>");
            }

            if (!found) {
                out.println("<tr><td colspan='5'>No flights found for the selected criteria.</td></tr>");
            }

            out.println("</table>");

            rs.close();
            ps.close();
            connection.close();

        } 
        catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error retrieving flights.</h3>");
        }   
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String flightNo = request.getParameter("flightNo");
        String flightName = request.getParameter("flightName");
        String fromCity = request.getParameter("fromCity");
        String destination = request.getParameter("destination");
        String date=request.getParameter("date");
        String departureTime = request.getParameter("departure_time");
        String arrivalTime = request.getParameter("arrival_time");
        double ticketPrice = Double.parseDouble(request.getParameter("ticket_price"));
        int no_of_seats=Integer.parseInt(request.getParameter("no_of_seats"));
        
       try{ Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/frs?useSSL=false&serverTimezone=UTC","root" ,"riya@16" );
            String checkQuery = "SELECT * FROM flightList WHERE flight_No = ?";
            PreparedStatement checkPs = connection.prepareStatement(checkQuery);
            checkPs.setString(1, flightNo);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                //flight details already exists, show error message
                request.setAttribute("errorMessage", "You have already submitted the flight details!");
                request.getRequestDispatcher("FlightDetailsAlreadySubmit.jsp").forward(request, response);
                return;
            }
            
            String sql = "INSERT INTO flightList (flight_No, flightName, fromCity, toCity, date, departureTime, arrivalTime, ticketPrice, no_of_seats) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, flightNo);
            ps.setString(2, flightName);
            ps.setString(3, fromCity);
            ps.setString(4, destination);
            ps.setString(5, date);
            ps.setString(6, departureTime);
            ps.setString(7, arrivalTime);
            ps.setDouble(8, ticketPrice);
            ps.setInt(9, no_of_seats);
            
            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("Flight details added successfully.");
                RequestDispatcher dispatcher=request.getRequestDispatcher("/FlightDetailsSubmit.jsp");
                dispatcher.forward(request,response);
            }
            else{
                out.println("<h2>Error! Please Try again later.</h2>");
            }
            ps.close();
            connection.close();
       
       }
       catch(ServletException | IOException | ClassNotFoundException | SQLException e){
           e.printStackTrace();
       }
    }
}
