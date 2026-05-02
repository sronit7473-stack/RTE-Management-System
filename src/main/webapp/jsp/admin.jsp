<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 5/2/2026
  Time: 11:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container">
        <span class="navbar-brand">Admin Dashboard</span>
        <a href="<%= request.getContextPath() %>/logout" class="btn btn-danger">Logout</a>
    </div>
</nav>

<div class="container mt-5 text-center">

    <h2>Welcome Admin</h2>

    <a href="<%= request.getContextPath() %>/student?action=list"
       class="btn btn-primary">
        Manage Students
    </a>

</div>

</body>
</html>