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
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       String email = request.getParameter("email");
        String password = request.getParameter("password");

        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
        
        try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/frs?useSSL=false&serverTimezone=UTC","root","your_password");
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
                
                if("admin".equalsIgnoreCase(role)){
                RequestDispatcher dispatcher=request.getRequestDispatcher("/adminDashboard.jsp");
                dispatcher.forward(request,response);
                }
                else{
                RequestDispatcher dispatcher=request.getRequestDispatcher("/FlightList.jsp");
                dispatcher.forward(request,response);
                    
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
