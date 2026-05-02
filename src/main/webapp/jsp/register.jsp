<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 5/3/2026
  Time: 12:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Register</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">

        <div class="col-md-4">
            <div class="card shadow p-4">

                <h3 class="text-center mb-4">Register</h3>

                <form action="register" method="post">

                    <div class="mb-3">
                        <label>Username</label>
                        <input name="username" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label>Password</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label>Role</label>
                        <select name="role" class="form-select">
                            <option value="admin">Admin</option>
                            <option value="student">Student</option>
                        </select>
                    </div>

                    <button class="btn btn-success w-100">Register</button>

                </form>

                <p class="text-center mt-3">
                    <a href="login">Back to Login</a>
                </p>

            </div>
        </div>

    </div>
</div>

</body>
</html>