package com.rtemanagementsystem.controller;

import com.rtemanagementsystem.dao.NoticeDAO;
import com.rtemanagementsystem.dao.StudentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        StudentDAO studentDAO = new StudentDAO();
        NoticeDAO noticeDAO = new NoticeDAO();

        req.setAttribute("studentCount", studentDAO.getTotalStudentCount());
        req.setAttribute("courseCount", studentDAO.getDistinctCourseCount());
        req.setAttribute("notices", noticeDAO.getPublishedNotices(3));

        req.getRequestDispatcher("/jsp/home.jsp").forward(req, resp);
    }
}
