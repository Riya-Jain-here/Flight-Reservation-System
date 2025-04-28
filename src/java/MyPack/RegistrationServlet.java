package MyPack;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;

public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID=1L;
    
   public RegistrationServlet(){
       super();
   }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uname=request.getParameter("uname");
        String email=request.getParameter("email");
        String cno = request.getParameter("cno");
        //Long c_no = (cno!= null && !cno.isEmpty()) ? Long.parseLong(cno) : 0;
        String password=request.getParameter("password");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try{
            Connection connection = DatabaseConnection.initializeDatabase();
            
            String checkEmailQuery = "SELECT email FROM signup WHERE email = ?";
            PreparedStatement checkStmt = connection.prepareStatement(checkEmailQuery);
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();
             
            if (rs.next()) {
                request.setAttribute("errorMessage", "Email already registered! Please use a different email.");
                request.getRequestDispatcher("UnsuccessSignup.jsp").forward(request, response);
            } 
             
            else{
                String insert_in_sql="INSERT INTO signup" + "(userName,email,contactNo,Created_password) VALUES" +
                "(?,?,?,?)";
             
            PreparedStatement pstatement=connection.prepareStatement(insert_in_sql);
            
            if (uname == null || uname.trim().isEmpty()) {
              pstatement.setNull(1,Types.VARCHAR);
            }
            else{
            pstatement.setString(1, uname);
            }
            
            if (email == null || email.trim().isEmpty()) {
             pstatement.setNull(2,Types.VARCHAR);
             }
            else{
            pstatement.setString(2, email);
            }
            
            if(cno==null || cno.trim().isEmpty()){
                pstatement.setNull(3,Types.BIGINT);
            }
            else{
            pstatement.setString(3, cno);
            }
            
            if(password==null||password.trim().isEmpty()){
                pstatement.setNull(4,Types.VARCHAR);
            }
            else{
            pstatement.setString(4, password);
            }
            
            
            int res=pstatement.executeUpdate();
            System.out.println(pstatement);
            
            
            if (res > 0) {
                System.out.println("<h3>Account created successfully!</h3>");
            } 
            else {
               System.out.println("<h3>Signup failed. Try again.</h3>");
            }
            
            RequestDispatcher dispatcher=request.getRequestDispatcher("/successSignup.jsp");
            dispatcher.forward(request,response);
            pstatement.close();
            connection.close();
                
            }
        }
       catch(Exception e){
            e.printStackTrace();
        }
    }
}
