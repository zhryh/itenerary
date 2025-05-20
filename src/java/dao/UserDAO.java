/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;
import util.DatabaseConnection;

public class UserDAO {

    /**
     * Authenticate a user based on username and password.
     *
     * @param username the username of the user
     * @param password the password of the user
     * @return User object if authenticated, null otherwise
     * @throws SQLException if a database access error occurs
     */
    public User authenticate(String username, String password) throws SQLException {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = DatabaseConnection.getConnection();
            String query = "SELECT * FROM Users WHERE username = ? AND password = ?";
            pst = conn.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, password); // Note: For production, compare hashed passwords
            rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("userId"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
            }
        } finally {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (conn != null) conn.close();
        }

        return user;
    }

    /**
     * Register a new user in the database.
     *
     * @param user the User object containing user details
     * @return true if registration was successful, false otherwise
     * @throws SQLException if a database access error occurs
     */
    public boolean registerUser(User user) throws SQLException {
        String query = "INSERT INTO Users (username, password, email) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {
            pst.setString(1, user.getUsername());
            pst.setString(2, user.getPassword());
            pst.setString(3, user.getEmail());
            return pst.executeUpdate() > 0;
        }
    }

    /**
     * Check if a username is already taken.
     *
     * @param username the username to check
     * @return true if the username is taken, false otherwise
     * @throws SQLException if a database access error occurs
     */
    public boolean isUsernameTaken(String username) throws SQLException {
        String query = "SELECT COUNT(*) AS count FROM Users WHERE username = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {
            pst.setString(1, username);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count") > 0;
                }
            }
        }
        return false;
    }
}
