<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>E Ticket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background:#eef2f3;">
<%
    String ticketIdParam = request.getParameter("ticket_id");
    if (ticketIdParam == null) {
        response.sendRedirect("userDashboard.jsp?error=InvalidTicket");
        return;
    }

    int ticket_id = Integer.parseInt(ticketIdParam);
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        conn = MyPack.DatabaseConnection.initializeDatabase();
        ps = conn.prepareStatement("SELECT * FROM bookedList WHERE ticket_id = ?");
        ps.setInt(1, ticket_id);
        rs = ps.executeQuery();

        if (!rs.next()) {
            out.println("<h3 class='text-danger text-center mt-5'>No ticket found!</h3>");
            return;
        }

        // Store details
        String passengerName = rs.getString("passenger_name");
        String email = rs.getString("passenger_email");
        String flightName = rs.getString("flight_name");
        String departureDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("departure_date"));
        String bookingDate = new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("booking_date"));
        int seats = rs.getInt("no_of_seats");
        double price = rs.getDouble("ticket_price");
        String paymentStatus = rs.getString("payment_status");
%>

<div class="container mt-5 p-4 bg-white shadow rounded" style="max-width:700px;">
    <h2 class="text-center mb-4">E-Ticket</h2>
    <table class="table table-bordered">
        <tr><th>Ticket ID</th><td><%= ticket_id %></td></tr>
        <tr><th>Passenger</th><td><%= passengerName %></td></tr>
        <tr><th>Email</th><td><%= email %></td></tr>
        <tr><th>Flight</th><td><%= flightName %></td></tr>
        <tr><th>Departure Date</th><td><%= departureDate %></td></tr>
        <tr><th>Booking Date</th><td><%= bookingDate %></td></tr>
        <tr><th>No. of Seats</th><td><%= seats %></td></tr>
        <tr><th>Total Price</th><td>&#8377; <%= price %></td></tr>
        <tr><th>Payment Status</th><td><span class="badge bg-<%= paymentStatus.equals("Completed") ? "success" : "warning" %>">
            <%= paymentStatus %></span></td></tr>
    </table>

    <div class="text-center mt-4">
        <a href="DownloadEticketServlet?ticket_id=<%= ticket_id %>" class="btn btn-primary me-3">Download E-Ticket</a>
        <% if (!paymentStatus.equals("Completed")) { %>
        <a href="Payment.jsp?ticket_id=<%= ticket_id %>" class="btn btn-success">Proceed to Payment</a>
        <% } else { %>
        <a href="userDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        <% } %>
    </div>
</div>

<%
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("<h5 class='text-danger text-center mt-4'>Error loading ticket.</h5>");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>

