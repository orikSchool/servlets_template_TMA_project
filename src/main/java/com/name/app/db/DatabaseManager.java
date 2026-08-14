package com.name.app.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseManager {

    // File-based H2 DB — stored at ~/myapp-db/data (outside the project)
    private static final String DB_URL = "jdbc:h2:~/myapp-db/data;AUTO_SERVER=TRUE";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "";

    static {
        try {
            Class.forName("org.h2.Driver"); // explicitly load the driver
            initDatabase(); // יצירת הטבלאות במידה ולא קיימות בלחיצת העלייה
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("H2 Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    /**
     * פונקציה ליצירת ה-Schema של הטבלאות במידה והן עדיין לא קיימות
     */
    private static void initDatabase() {
        // 1. טבלת משתמשים
        String createUsersTable = "CREATE TABLE IF NOT EXISTS users (" +
                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                "username VARCHAR(50) UNIQUE NOT NULL, " +
                "password VARCHAR(50) NOT NULL" +
                ");";

        // 2. טבלת ציונים במתמטיקה
        String createGradesTable = "CREATE TABLE IF NOT EXISTS grades (" +
                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                "username VARCHAR(50) UNIQUE NOT NULL, " +
                "g11_exam INT, g11_magen INT, g11_war BOOLEAN, g11_final DOUBLE, " +
                "g12_exam INT, g12_magen INT, g12_war BOOLEAN, g12_final DOUBLE, " +
                "total_final DOUBLE, " +
                "FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE" +
                ");";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {

            stmt.execute(createUsersTable);
            stmt.execute(createGradesTable);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        // הרצה ידנית לבדיקת התחברות ויצירת הטבלאות
        try (Connection conn = DatabaseManager.getConnection()) {
            System.out.println("Connection to H2 successful and tables initialized!");
        }
    }
}