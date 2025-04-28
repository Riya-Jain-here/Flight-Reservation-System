package MyPack;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

public class paymentupdate extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("Login.jsp?error=PleaseLogin");
            return;
        }

        String email = (String) session.getAttribute("email");
        if (email == null || email.isEmpty()) {
            response.sendRedirect("Login.jsp?error=EmailMissing");
            return;
        }

        String name = request.getParameter("name");
        String cvv = request.getParameter("cvv");

        int ticketId = -1;
        double ticketPrice = 0;

        try {
            Connection connection = DatabaseConnection.initializeDatabase();

            // Fetch `ticket_id` and `ticketPrice` for the given email where payment is pending
            String fetchQuery = "SELECT ticket_id, ticketPrice FROM bookedList WHERE passenger_email = ? AND payment_status = 'Pending' LIMIT 1";
            PreparedStatement fetchPs = connection.prepareStatement(fetchQuery);
            fetchPs.setString(1, email);
            ResultSet rs = fetchPs.executeQuery();

            if (rs.next()) {
                ticketId = rs.getInt("ticket_id");
                ticketPrice = rs.getDouble("ticketPrice");
            } else {
                response.sendRedirect("userDashboard.jsp?error=NoPendingTicket");
                return;
            }

            // Hash CVV for security
            String hashedCVV = hashCVV(cvv);

            // Insert payment details
            String insertPaymentQuery = "INSERT INTO payment (name, ticket_id, user_email, cvv_hash, amount, payment_status) VALUES (?, ?, ?, ?, ?, 'Completed')";
            PreparedStatement ps = connection.prepareStatement(insertPaymentQuery);
            ps.setString(1, name);
            ps.setInt(2, ticketId);
            ps.setString(3, email);
            ps.setString(4, hashedCVV);
            ps.setDouble(5, ticketPrice);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                // Update bookedList payment status
                String updateStatusQuery = "UPDATE bookedList SET payment_status = 'Completed' WHERE ticket_id = ?";
                PreparedStatement updatePs = connection.prepareStatement(updateStatusQuery);
                updatePs.setInt(1, ticketId);
                updatePs.executeUpdate();

                response.sendRedirect("SuccessPayment.jsp");
            } else {
                response.sendRedirect("Payment.jsp?error=PaymentFailed");
            }

            ps.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException | NoSuchAlgorithmException ex) {
            ex.printStackTrace();
            response.sendRedirect("Payment.jsp?error=InternalServerError");
        }
    }

    private String hashCVV(String cvv) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(cvv.getBytes());
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            hexString.append(String.format("%02x", b));
        }
        return hexString.toString();
        
    }
}
