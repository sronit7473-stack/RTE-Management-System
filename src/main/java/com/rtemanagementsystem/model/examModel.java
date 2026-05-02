package com.rtemanagementsystem.model;

import java.sql.Time;

public class examModel {
    private int id;
    private  String subject;
    private String date;
    private Time time;
    private String venue;

    public examModel(int id, String subject, String date, Time time, String venue) {
        this.id = id;
        this.subject = subject;
        this.date = date;
        this.time = time;
        this.venue = venue;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Time getTime() {
        return time;
    }

    public void setTime(Time time) {
        this.time = time;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }
}
