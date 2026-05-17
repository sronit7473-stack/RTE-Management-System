package com.rtemanagementsystem.dao;

import com.rtemanagementsystem.model.NoticeModel;
import java.sql.*;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class NoticeDAO {

    private static final DateTimeFormatter DISPLAY_FMT = DateTimeFormatter.ofPattern("MMM dd, yyyy");

    public List<NoticeModel> getPublishedNotices(int limit) {
        List<NoticeModel> list = new ArrayList<>();
        try {
            Connection con = DbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT id, title, content, category, published_date " +
                "FROM notices WHERE published = TRUE " +
                "ORDER BY published_date DESC LIMIT ?"
            );
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                java.sql.Date sqlDate = rs.getDate("published_date");
                String formatted = sqlDate != null
                    ? sqlDate.toLocalDate().format(DISPLAY_FMT)
                    : "";
                list.add(new NoticeModel(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getString("category"),
                    formatted
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
