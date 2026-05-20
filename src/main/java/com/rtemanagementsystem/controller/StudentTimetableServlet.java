package com.rtemanagementsystem.controller;

import com.rtemanagementsystem.dao.NotificationDAO;
import com.rtemanagementsystem.dao.SectionDAO;
import com.rtemanagementsystem.dao.StudentDAO;
import com.rtemanagementsystem.dao.routineDAO;
import com.rtemanagementsystem.model.routinesModel;
import com.rtemanagementsystem.model.studentsModel;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class StudentTimetableServlet extends HttpServlet {

    private static final String[] DAYS = {"Monday","Tuesday","Wednesday","Thursday","Friday"};

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        int studentId = (session != null && session.getAttribute("studentId") != null)
                ? (int) session.getAttribute("studentId") : 0;
        int userId = (session != null && session.getAttribute("userId") != null)
                ? (int) session.getAttribute("userId") : 0;

        studentsModel student = new StudentDAO().getStudentById(studentId);
        int defaultSectionId = (student != null) ? student.getSectionId() : 0;

        String sectionParam = req.getParameter("sectionId");
        int selectedSection = (sectionParam != null && !sectionParam.isEmpty())
                ? parseInt(sectionParam, defaultSectionId) : defaultSectionId;

        List<routinesModel> all = selectedSection > 0
                ? new routineDAO().findBySection(selectedSection)
                : new ArrayList<>();

        Map<String, List<routinesModel>> byDay = new LinkedHashMap<>();
        for (String d : DAYS) byDay.put(d, new ArrayList<>());
        for (routinesModel r : all) {
            String key = capitalize(r.getDay());
            byDay.computeIfAbsent(key, k -> new ArrayList<>()).add(r);
        }

        req.setAttribute("allRoutines",     all);
        req.setAttribute("byDay",           byDay);
        req.setAttribute("days",            DAYS);
        req.setAttribute("sections",        new SectionDAO().getAllSections());
        req.setAttribute("selectedSection", selectedSection);
        int targetId = studentId > 0 ? studentId : userId;
        req.setAttribute("unreadCount", new NotificationDAO().countUnread(targetId));

        req.getRequestDispatcher("/jsp/student/timetable.jsp").forward(req, resp);
    }

    private String capitalize(String s) {
        if (s == null || s.isEmpty()) return s;
        return s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase();
    }

    private int parseInt(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }
}
