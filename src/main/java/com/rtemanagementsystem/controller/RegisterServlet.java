package com.rtemanagementsystem.controller;

import com.rtemanagementsystem.dao.UserDAO;
import com.rtemanagementsystem.model.UserModel;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

public class  RegisterServlet extends HttpServlet {

    String registerPage = "/jsp/register.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher(registerPage).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("user" +
                "name");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        // ✅ Validation
        if (username == null || username.isEmpty() ||
                password == null || password.isEmpty() ||
                role == null || role.isEmpty()) {

            req.setAttribute("error", "All fields are required!");
            req.getRequestDispatcher(registerPage).forward(req, resp);
            return;
        }

        // 🔐 HASH PASSWORD USING BCrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Create user object
        UserModel user = new UserModel(0, username, hashedPassword, role);

        // Save to DB
        UserDAO userDAO = new UserDAO();
        userDAO.register(user);

        // Redirect to login page
        resp.sendRedirect("login");
    }
}