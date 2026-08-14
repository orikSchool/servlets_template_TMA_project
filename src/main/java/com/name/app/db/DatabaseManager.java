package com.name.app.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseManager {

    private static final String DB_URL = "jdbc:h2:~/myapp-db/data;AUTO_SERVER=TRUE";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "";

    static {
        try {
            Class.forName("org.h2.Driver");
            initDatabase();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("H2 Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    private static void initDatabase() {
        String createUsersTable = "CREATE TABLE IF NOT EXISTS users (" +
                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                "username VARCHAR(50) UNIQUE NOT NULL, " +
                "password VARCHAR(50) NOT NULL" +
                ");";

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
        try (Connection conn = DatabaseManager.getConnection()) {
            System.out.println("Connection to H2 successful and tables initialized!");
        }
    }
}