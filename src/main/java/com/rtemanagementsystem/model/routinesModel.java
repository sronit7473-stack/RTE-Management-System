package com.rtemanagementsystem.model;

import java.sql.Time;

public class routinesModel {
    private int id;
    private String course;
    private String instructor;
    private String room;
    private String day;
    private String time;

    public routinesModel(int id, String course, String instructor, String room, String day, String time) {
        this.id = id;
        this.course = course;
        this.instructor = instructor;
        this.room = room;
        this.day = day;
        this.time = time;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getInstructor() {
        return instructor;
    }

    public void setInstructor(String instructor) {
        this.instructor = instructor;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
}

