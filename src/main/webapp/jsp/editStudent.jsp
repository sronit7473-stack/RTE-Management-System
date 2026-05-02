<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 5/2/2026
  Time: 9:54 PM
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>Edit Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-5">

    <h2>Edit Student</h2>

    <form action="student" method="post">

        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${student.id}">

        <input class="form-control mb-2" name="name" value="${student.name}">
        <input class="form-control mb-2" name="email" value="${student.email}">
        <input class="form-control mb-2" name="course" value="${student.course}">

        <button class="btn btn-primary">Update</button>

    </form>

</div>

</body>
</html>
