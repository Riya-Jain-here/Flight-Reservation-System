package MyPack;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseConnection {
    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        Properties prop = new Properties();
        try (FileInputStream input = new FileInputStream("C:\\Users\\Hp\\OneDrive\\Documents\\NetBeansProjects\\FlightReservationSystem\\web\\WEB-INF\\database.properties")) { 
            prop.load(input);
            String dbUrl = prop.getProperty("db.url");
            String dbUser = prop.getProperty("db.user");
            String dbPassword = prop.getProperty("db.password");
            
            Class.forName("com.mysql.cj.jdbc.Driver");  
            return DriverManager.getConnection(dbUrl, dbUser, dbPassword); 
        } catch (IOException e) {
            e.printStackTrace();
            throw new SQLException("Unable to load database properties.");
        }
    }
}
