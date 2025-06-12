/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context; 

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level; 
import java.util.logging.Logger; 

public class DBContext2 {

    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=SWP391DB;encrypt=false;characterEncoding=UTF-8;useUnicode=true";
    private static final String USER = "sa";
    private static final String PASSWORD = "sa";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException ex) {
        
            Logger.getLogger(DBContext2.class.getName()).log(Level.SEVERE, "SQL Server JDBC Driver not found.", ex);
          
            throw new SQLException("Cannot find JDBC driver. Please ensure the SQL Server JDBC driver is in your classpath.", ex);
        }
    }
}