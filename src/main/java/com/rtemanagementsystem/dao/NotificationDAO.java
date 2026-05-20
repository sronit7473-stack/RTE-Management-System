package com.rtemanagementsystem.dao;

import com.rtemanagementsystem.model.NotificationModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    public NotificationDAO() { ensureTable(); }

    private void ensureTable() {
        try {
            DbConnection.getConnection().prepareStatement(
                "CREATE TABLE IF NOT EXISTS notifications (" +
                "Notfi_id  INT AUTO_INCREMENT PRIMARY KEY," +
                "User_id   INT NOT NULL," +
                "Message   TEXT," +
                "Is_read   TINYINT(1) DEFAULT 0)"
            ).executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<NotificationModel> getByStudentId(int studentId) {
        List<NotificationModel> list = new ArrayList<>();
        String sql = "SELECT Notfi_id, User_id, Message, Is_read " +
                     "FROM notifications WHERE User_id = ? ORDER BY Notfi_id DESC";
        try {
            Connection con = DbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<NotificationModel> getRecentByStudentId(int studentId, int limit) {
        List<NotificationModel> list = new ArrayList<>();
        String sql = "SELECT Notfi_id, User_id, Message, Is_read " +
                     "FROM notifications WHERE User_id = ? ORDER BY Notfi_id DESC LIMIT ?";
        try {
            Connection con = DbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getUnreadCount(int studentId) {
        String sql = "SELECT COUNT(*) FROM notifications WHERE User_id = ? AND Is_read = 0";
        try {
            Connection con = DbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countUnread(int studentId) {
        return getUnreadCount(studentId);
    }

    public void markAsRead(int notificationId, int studentId) {
        String sql = "UPDATE notifications SET Is_read = 1 WHERE Notfi_id = ? AND User_id = ?";
        try {
            Connection con = DbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, notificationId);
            ps.setInt(2, studentId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void markAllAsRead(int studentId) {
        String sql = "UPDATE notifications SET Is_read = 1 WHERE User_id = ?";
        try {
            Connection con = DbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void notifyBySection(int sectionId, String message) {
        if (sectionId <= 0 || message == null || message.trim().isEmpty()) return;

        String sql = "INSERT INTO notifications(User_id, Message, Is_read) " +
                     "SELECT s.id, ?, 0 FROM students s " +
                     "WHERE s.Section_Id = ?";
        try {
            Connection con = DbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, message.trim());
            ps.setInt(2, sectionId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void notifyAllStudents(String message) {
        if (message == null || message.trim().isEmpty()) return;
        String trimmed = message.trim();

        String sql = "INSERT INTO notifications(User_id, Message, Is_read) " +
                     "SELECT s.id, ?, 0 FROM students s";
        try {
            Connection con = DbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, trimmed);
            int rows = ps.executeUpdate();
            System.out.println("[NotificationDAO] notifyAllStudents via students: " + rows + " rows inserted");
            if (rows > 0) return;
        } catch (Exception e) { e.printStackTrace(); }

        // Fallback: students table is empty — insert via users table
        String fallback = "INSERT INTO notifications(User_id, Message, Is_read) " +
                          "SELECT u.Id, ?, 0 FROM users u WHERE LOWER(u.Role) = 'student'";
        try {
            Connection con = DbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(fallback);
            ps.setString(1, trimmed);
            int rows = ps.executeUpdate();
            System.out.println("[NotificationDAO] notifyAllStudents via users fallback: " + rows + " rows inserted");
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void insert(int studentId, String message) {
        if (studentId <= 0 || message == null || message.trim().isEmpty()) return;
        String sql = "INSERT INTO notifications(User_id, Message, Is_read) VALUES(?, ?, 0)";
        try {
            Connection con = DbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setString(2, message.trim());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    private String titleFromMessage(String message) {
        if (message == null) return "Notification";
        String trimmed = message.trim();
        if (trimmed.isEmpty()) return "Notification";
        int idx = trimmed.indexOf(':');
        if (idx > 0) {
            return trimmed.substring(0, idx).trim();
        }
        return trimmed.length() > 70 ? trimmed.substring(0, 70).trim() : trimmed;
    }

    private NotificationModel map(ResultSet rs) throws SQLException {
        String msg = rs.getString("Message");
        String title = titleFromMessage(msg);
        return new NotificationModel(
                rs.getInt("Notfi_id"),
                rs.getInt("User_id"),
                title,
                msg,
                rs.getInt("Is_read") == 1,
                ""
        );
    }
}
