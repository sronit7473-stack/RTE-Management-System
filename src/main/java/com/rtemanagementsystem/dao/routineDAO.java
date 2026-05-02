package com.rtemanagementsystem.dao;

import com.rtemanagementsystem.model.routinesModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class routineDAO {
    public void add(routinesModel r){
        try{
            Connection con = DbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO routines VALUES (null,?,?,?,?,?)");

            ps.setString(1,r.getCourse());
            ps.setString(2,r.getInstructor());
            ps.setString(3,r.getRoom());
            ps.setString(4,r.getDay());
            ps.setString(5,r.getTime());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


}
