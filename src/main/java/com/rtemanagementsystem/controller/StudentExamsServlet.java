package com.rtemanagementsystem.controller;

import com.rtemanagementsystem.dao.ExamDAO;
import com.rtemanagementsystem.dao.NotificationDAO;
import com.rtemanagementsystem.dao.StudentDAO;
import com.rtemanagementsystem.model.studentsModel;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class StudentExamsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        int studentId = (session != null && session.getAttribute("studentId") != null)
                ? (int) session.getAttribute("studentId") : 0;
        int userId = (session != null && session.getAttribute("userId") != null)
                ? (int) session.getAttribute("userId") : 0;

        studentsModel student = new StudentDAO().getStudentById(studentId);
        int sectionId = student != null ? student.getSectionId() : 0;
        String tab = "past".equalsIgnoreCase(req.getParameter("tab")) ? "past" : "upcoming";

        ExamDAO examDAO = new ExamDAO();
        req.setAttribute("exams", "past".equals(tab)
                ? examDAO.findPastForStudent(sectionId)
                : examDAO.findUpcomingForStudent(sectionId));
        req.setAttribute("activeTab", tab);

        int targetId = studentId > 0 ? studentId : userId;
        req.setAttribute("unreadCount", new NotificationDAO().countUnread(targetId));

        req.getRequestDispatcher("/jsp/student/exams.jsp").forward(req, resp);
    }
}
