package MyPack;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       response.sendRedirect("Login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String flightId = request.getParameter("flight_id");

        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
        
        try{
        Connection connection = DatabaseConnection.initializeDatabase();
        
        String sql = "SELECT user_id, userName,role FROM signup WHERE email=? AND Created_password=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int user_id = rs.getInt("user_id");
                String userName = rs.getString("userName");
                String role = rs.getString("role");
                
                
                HttpSession session = request.getSession(true);
                session.setAttribute("user_id", user_id);
                System.out.println("User logged in with ID: " + user_id); 
                session.setAttribute("email", email); 
                session.setAttribute("userName", rs.getString("userName")); 
                session.setAttribute("role", role);
                
                // Set sessionStorage using JavaScript (client-side)
                out.println("<html><body>");
                out.println("<script>");
                out.println("sessionStorage.setItem('email', '" + email + "');");
                out.println("sessionStorage.setItem('userName', '" + userName + "');");
               
                out.println("window.location.href = 'UserLogin.jsp';");
                out.println("</script>");
                out.println("</body></html>");
                
                if("admin".equalsIgnoreCase(role)){
                    RequestDispatcher dispatcher=request.getRequestDispatcher("/adminDashboard.jsp");
                    dispatcher.forward(request,response);
                }
                
                if (flightId != null && !flightId.isEmpty()) {
                    // User tried to book a flight before login, so check existing booking
                    String checkBookingQuery = "SELECT ticket_id, payment_status FROM bookedList WHERE user_id = ? AND flight_id = ?";
                    PreparedStatement bookingPs = connection.prepareStatement(checkBookingQuery);
                    bookingPs.setInt(1, user_id);
                    bookingPs.setString(2, flightId);
                    ResultSet bookingRs = bookingPs.executeQuery();

                    if (bookingRs.next()) {
                        String paymentStatus = bookingRs.getString("payment_status");

                        if ("Pending".equalsIgnoreCase(paymentStatus)) {
                            // Redirect to dashboard with flags to highlight booking
                            response.sendRedirect("userDashboard.jsp?flight_id=" + flightId + "&pendingPayment=true");
                        } else {
                            // Payment is done, just show book ticket page again
                            response.sendRedirect("BookTicket.jsp?flight_id=" + flightId);
                        }
                    } else {
                        // No booking yet, show book ticket page
                        response.sendRedirect("BookTicket.jsp?flight_id=" + flightId);
                    }
                    bookingRs.close();
                    bookingPs.close();
                }
                
                else{
                /*RequestDispatcher dispatcher=request.getRequestDispatcher("/UserLogin.jsp");
                dispatcher.forward(request,response);*/
                 out.println("window.location.href = 'UserLogin.jsp';");
                    
                }    
            } 
            else {
                out.println("<h3>Invalid Email or Password!</h3>");
                out.println("<a href='Login.jsp'>Try Again</a>");
            }
            rs.close();
            ps.close();
            connection.close();
        } 
        catch (SQLException ex) {
            ex.printStackTrace();
        } 
        catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }    
    }
}
