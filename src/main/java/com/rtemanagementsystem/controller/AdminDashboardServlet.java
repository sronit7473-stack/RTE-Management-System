package com.rtemanagementsystem.controller;

import com.rtemanagementsystem.dao.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("totalStudents",  new StudentDAO().getTotalStudentCount());
        req.setAttribute("totalCourses",   new CourseDAO().countAll());
        req.setAttribute("upcomingExams",  new ExamDAO().countUpcoming());
        req.setAttribute("totalMaterials", new MaterialDAO().countAll());
        req.setAttribute("recentNotices",  new NoticeDAO().getRecentAdmin(5));
        req.setAttribute("recentContacts", new ContactDAO().getRecent(5));
        req.setAttribute("unreadContacts", new ContactDAO().countUnread());

        req.getRequestDispatcher("/jsp/admin/dashboard.jsp").forward(req, resp);
    }
}
