package com.rtemanagementsystem.model;

public class NoticeModel {
    private int id;
    private String title;
    private String content;
    private String category;
    private String formattedDate;

    public NoticeModel(int id, String title, String content, String category, String formattedDate) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.category = category;
        this.formattedDate = formattedDate;
    }

    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getContent() { return content; }
    public String getCategory() { return category; }
    public String getFormattedDate() { return formattedDate; }
}
