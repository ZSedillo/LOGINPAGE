package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpServlet;
import controller.Security;

public class EncryptPasswords extends HttpServlet{
    
    public void encryptPasswords(String jdbcUrl, String dbUsername, String dbPassword,String cipherTransformation) throws NullPointerException{
            try {
            Connection con = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

            String query = "SELECT password FROM USER_INFO";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            String setPassword = null;

            while (rs.next()) {
                String password = rs.getString("password");
                setPassword = Security.encrypt(password,cipherTransformation);
                
                String updateQuery = "UPDATE USER_INFO SET password = ? WHERE password = ?";
                PreparedStatement updatePs = con.prepareStatement(updateQuery);
                updatePs.setString(1, setPassword);
                updatePs.setString(2, password);
                updatePs.executeUpdate();
                updatePs.close();
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }
}
