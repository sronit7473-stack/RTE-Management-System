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
    <style>
        body {
            background: #f4f6f8;
        }

        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .table-wrap {
            background: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(33, 37, 41, 0.06);
        }

        .table {
            margin-bottom: 0;
        }
    </style>
</head>

<body>
<p class="text-success text-center">
    <%= session.getAttribute("success") != null ? session.getAttribute("success") : "" %>
</p>
<%
    session.removeAttribute("success");
%>
<div class="container mt-5">

    <div class="page-header">
        <h2 class="mb-0">Student List</h2>

        <button type="button"
                class="btn btn-success"
                data-bs-toggle="modal"
                data-bs-target="#addStudentModal">
            Add Student
        </button>
    </div>

    <div class="table-wrap">
        <table class="table table-bordered table-hover align-middle">

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
                        <button type="button"
                                class="btn btn-warning btn-sm edit-student-btn"
                                data-bs-toggle="modal"
                                data-bs-target="#editStudentModal"
                                data-student-id="${s.id}"
                                data-student-name="${s.name}"
                                data-student-email="${s.email}"
                                data-student-course="${s.course}">
                            Edit
                        </button>
                        <button type="button"
                                class="btn btn-secondary btn-sm deactivate-student-btn"
                                data-student-id="${s.id}"
                                data-student-name="${s.name}">
                            Deactivate
                        </button>
                        <button type="button"
                                class="btn btn-danger btn-sm delete-student-btn"
                                data-bs-toggle="modal"
                                data-bs-target="#deleteStudentModal"
                                data-student-id="${s.id}"
                                data-student-name="${s.name}">
                            Delete
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>

        </table>
    </div>

</div>

<div class="modal fade" id="deleteStudentModal" tabindex="-1" aria-labelledby="deleteStudentModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteStudentModalLabel">Delete Student</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p class="mb-0" id="deleteStudentMessage">Do you really want to delete this student?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <a href="#" class="btn btn-danger" id="confirmDeleteStudentBtn">Delete</a>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="editStudentModal" tabindex="-1" aria-labelledby="editStudentModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="<%= request.getContextPath() %>/student" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editStudentModalLabel">Edit Student</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" id="editStudentId" name="id" value="${student.id}">

                    <label class="form-label" for="editStudentName">Name</label>
                    <input id="editStudentName" class="form-control mb-3" name="name" value="${student.name}" required>

                    <label class="form-label" for="editStudentEmail">Email</label>
                    <input id="editStudentEmail" class="form-control mb-3" type="email" name="email" value="${student.email}" required>

                    <label class="form-label" for="editStudentCourse">Course</label>
                    <input id="editStudentCourse" class="form-control" name="course" value="${student.course}" required>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update Student</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="addStudentModal" tabindex="-1" aria-labelledby="addStudentModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="<%= request.getContextPath() %>/student" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="addStudentModalLabel">Add Student</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <input type="hidden" name="action" value="add">

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <label class="form-label" for="studentName">Name</label>
                    <input id="studentName" class="form-control mb-3" name="name" placeholder="Name" value="${name}" required>

                    <label class="form-label" for="studentEmail">Email</label>
                    <input id="studentEmail" class="form-control mb-3" type="email" name="email" placeholder="Email" value="${email}" required>

                    <label class="form-label" for="studentCourse">Course</label>
                    <input id="studentCourse" class="form-control" name="course" placeholder="Course" value="${course}" required>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">Add Student</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const contextPath = '<%= request.getContextPath() %>';

    document.querySelectorAll('.edit-student-btn').forEach((button) => {
        button.addEventListener('click', () => {
            document.getElementById('editStudentId').value = button.dataset.studentId;
            document.getElementById('editStudentName').value = button.dataset.studentName;
            document.getElementById('editStudentEmail').value = button.dataset.studentEmail;
            document.getElementById('editStudentCourse').value = button.dataset.studentCourse;
        });
    });

    document.querySelectorAll('.delete-student-btn').forEach((button) => {
        button.addEventListener('click', () => {
            const studentId = button.dataset.studentId;
            const studentName = button.dataset.studentName;

            document.getElementById('deleteStudentMessage').textContent =
                `Do you really want to delete student "${studentName}"?`;
            document.getElementById('confirmDeleteStudentBtn').href =
                `${contextPath}/student?action=delete&id=${studentId}`;
        });
    });

    document.querySelectorAll('.deactivate-student-btn').forEach((button) => {
        button.addEventListener('click', () => {
            const studentName = button.dataset.studentName;
            alert(`Deactivate requested for "${studentName}". Backend action is not implemented yet.`);
        });
    });
</script>
<c:if test="${showAddModal}">
    <script>
        const addStudentModal = new bootstrap.Modal(document.getElementById('addStudentModal'));
        addStudentModal.show();
    </script>
</c:if>
<c:if test="${showEditModal}">
    <script>
        const editStudentModal = new bootstrap.Modal(document.getElementById('editStudentModal'));
        editStudentModal.show();
    </script>
</c:if>

</body>
</html>
