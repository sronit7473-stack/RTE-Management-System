package com.rtemanagementsystem.controller;

import com.rtemanagementsystem.dao.UserDAO;
import com.rtemanagementsystem.model.UserModel;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;


public class LoginServlet extends HttpServlet {

    String loginPage = "/jsp/login.jsp";

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher(loginPage).forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.isEmpty() ||
                password == null || password.isEmpty()) {

            req.setAttribute("error", "All fields required!");
            req.getRequestDispatcher(loginPage).forward(req, resp);
            return;
        }

        UserDAO dao = new UserDAO();
        UserModel user = dao.getUserDetails(username);

        if (user == null) {
            req.setAttribute("error", "User not found!");
            req.getRequestDispatcher(loginPage).forward(req, resp);
            return;
        }

        if (!BCrypt.checkpw(password, user.getPassword())) {
            req.setAttribute("error", "Incorrect password!");
            req.getRequestDispatcher(loginPage).forward(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        session.setAttribute("user", user);

        if (user.getRole().equalsIgnoreCase("admin")) {
            resp.sendRedirect(req.getContextPath() + "/jsp/admin.jsp");
        } else {
            resp.sendRedirect(req.getContextPath() + "/jsp/student.jsp");
        }
    }
}