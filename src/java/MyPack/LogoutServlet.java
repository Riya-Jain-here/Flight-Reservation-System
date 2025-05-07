package MyPack;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import static java.lang.System.console;

public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); 
        if (session != null) {
            session.invalidate(); 
            System.out.println("Logout succesfully");
        }
        response.setContentType("text/html");
        response.getWriter().println("<html><body><script>");
        response.getWriter().println("sessionStorage.clear();");
        response.getWriter().println("window.location.href = 'Login.jsp';");
        response.getWriter().println("</script></body></html>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
      doGet(request, response);  
    }
}
