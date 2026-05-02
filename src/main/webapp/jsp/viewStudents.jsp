<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 5/2/2026
  Time: 9:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Students</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<p class="text-success text-center">
    <%= session.getAttribute("success") != null ? session.getAttribute("success") : "" %>
</p>
<%
    session.removeAttribute("success");
%>
<div class="container mt-5">

    <h2 class="mb-4">Student List</h2>

    <a href="<%= request.getContextPath() %>/jsp/addStudent.jsp"
       class="btn btn-success">
        Add Student
    </a>

    <table class="table table-bordered table-hover">

        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Course</th>
            <th>Action</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="s" items="${students}">
            <tr>
                <td>${s.id}</td>
                <td>${s.name}</td>
                <td>${s.email}</td>
                <td>${s.course}</td>

                <td>
                    <a href="student?action=edit&id=${s.id}" class="btn btn-warning btn-sm">Edit</a>
                    <a href="student?action=delete&id=${s.id}" class="btn btn-danger btn-sm">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>

    </table>

</div>

</body>
</html>