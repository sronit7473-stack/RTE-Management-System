package com.rtemanagementsystem.controller;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import com.rtemanagementsystem.dao.StudentDAO;
import com.rtemanagementsystem.model.studentsModel;


public class StudentServlet extends HttpServlet {

    StudentDAO dao = new StudentDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // LIST
        if (action == null || action.isEmpty() || "list".equals(action)) {
            List<studentsModel> list = dao.getAllStudents();
            req.setAttribute("students", list);
            req.getRequestDispatcher("/jsp/viewStudents.jsp").forward(req, resp);
        }

        // DELETE
        else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteStudent(id);
            resp.sendRedirect("student?action=list");
        }

        // EDIT
        else if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            studentsModel s = dao.getStudentById(id);
            req.setAttribute("student", s);
            req.setAttribute("showEditModal", true);
            req.setAttribute("students", dao.getAllStudents());
            req.getRequestDispatcher("/jsp/viewStudents.jsp").forward(req, resp);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // ADD
        if ("add".equals(action)) {

            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String course = req.getParameter("course");

            // check duplicate
            if (dao.existsByEmail(email)) {
                req.setAttribute("error", "Student with this email already exists!");
                req.setAttribute("name", name);
                req.setAttribute("email", email);
                req.setAttribute("course", course);
                req.setAttribute("showAddModal", true);
                req.setAttribute("students", dao.getAllStudents());

                req.getRequestDispatcher("/jsp/viewStudents.jsp").forward(req, resp);
                return;
            }

            studentsModel s = new studentsModel(0, name, email, course);
            dao.addStudent(s);

            // optional success message
            req.getSession().setAttribute("success", "Student added successfully!");
            resp.sendRedirect(req.getContextPath() + "/student?action=list");
        }

        // UPDATE
        else if ("update".equals(action)) {
            studentsModel s = new studentsModel(
                    Integer.parseInt(req.getParameter("id")),
                    req.getParameter("name"),
                    req.getParameter("email"),
                    req.getParameter("course")
            );

            dao.updateStudent(s);
            req.getSession().setAttribute("success", "Student updated successfully!");
            resp.sendRedirect(req.getContextPath() + "/student?action=list");
        }
    }
}
