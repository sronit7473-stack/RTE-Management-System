package com.rtemanagementsystem.dao;

import com.rtemanagementsystem.model.UserModel;
import java.sql.*;

public class UserDAO {

    // =========================
    // REGISTER USER
    // =========================
    public void register(UserModel user) {
        try {
            Connection con = DbConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO users (username, password, role) VALUES (?, ?, ?)"
            );

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword()); // already hashed using BCrypt
            ps.setString(3, user.getRole());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // =========================
    // GET USER BY USERNAME (FOR LOGIN)
    // =========================
    public UserModel getUserDetails(String username) {
        try {
            Connection con = DbConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM users WHERE username = ?"
            );

            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new UserModel(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"), // hashed password
                        rs.getString("role")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

}