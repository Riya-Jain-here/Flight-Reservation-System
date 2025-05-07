package MyPack;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");
        PreparedStatement ps=null;
        Connection connection=null;
        try{
        connection = DatabaseConnection.initializeDatabase();
        String sql = "INSERT INTO contact (name, email, message) VALUES (?, ?, ?)";
        ps = connection.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, message);
        ps.executeUpdate();

        request.setAttribute("successMessage", "Thank you, " + name + "! Your message has been sent.");
        request.getRequestDispatcher("ContactUs.jsp").forward(request, response);
        
        }
        catch(Exception e){
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<h3 style='color:red'>Error: " + e.getMessage() + "</h3>");
        }
        finally {
            try { 
                if (ps != null) ps.close(); 
            } 
            catch (Exception ignored) {
            }
            try {
                if (connection != null) connection.close();
            } catch (Exception ignored) {
            }
        }
    }
}
