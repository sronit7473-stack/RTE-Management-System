<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 5/2/2026
  Time: 9:53 PM
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>Add Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-5">

    <h2 class="mb-4">Add Student</h2>
    <p class="text-danger text-center">${error}</p>
    <form action="<%= request.getContextPath() %>/student" method="post">

        <input type="hidden" name="action" value="add">

        <input class="form-control mb-2" name="name" placeholder="Name" value="${name}">
        <input class="form-control mb-2" name="email" placeholder="Email" value="${email}">
        <input class="form-control mb-2" name="course" placeholder="Course" value="${course}">
        

        <button class="btn btn-success w-100">Add</button>
    </form>

</div>

</body>
</html>