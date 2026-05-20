package com.rtemanagementsystem.controller;

import com.rtemanagementsystem.dao.*;
import com.rtemanagementsystem.model.studentsModel;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.*;
import java.util.Locale;

public class StudentDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        int studentId = (session != null && session.getAttribute("studentId") != null)
                ? (int) session.getAttribute("studentId") : 0;
        int userId = (session != null && session.getAttribute("userId") != null)
                ? (int) session.getAttribute("userId") : 0;

        String today = LocalDate.now().getDayOfWeek()
                .getDisplayName(TextStyle.FULL, Locale.ENGLISH);

        routineDAO rDao  = new routineDAO();
        ExamDAO    eDao  = new ExamDAO();
        MaterialDAO mDao = new MaterialDAO();
        NotificationDAO nDao = new NotificationDAO();

        studentsModel student = new StudentDAO().getStudentById(studentId);
        int sectionId = (student != null) ? student.getSectionId() : 0;

        List<?> todayClasses = sectionId > 0
                ? rDao.findBySectionAndDay(sectionId, today)
                : new ArrayList<>();

        int effectiveId = studentId > 0 ? studentId : userId;
        int unreadCount = nDao.countUnread(effectiveId);

        req.setAttribute("todayClasses",    todayClasses);
        req.setAttribute("todayDay",        today);
        req.setAttribute("upcomingExams",   eDao.getUpcomingByStudentId(studentId));
        req.setAttribute("recentMaterials", mDao.getRecentByStudentId(studentId, 5));
        req.setAttribute("recentNotifs",    nDao.getRecentByStudentId(effectiveId, 5));
        req.setAttribute("unreadCount",     unreadCount);
        req.setAttribute("examsThisWeek",   eDao.countThisWeekByStudentId(studentId));
        req.setAttribute("newMaterials",    mDao.countNewByStudentId(studentId));

        req.getRequestDispatcher("/jsp/student/dashboard.jsp").forward(req, resp);
    }
}
