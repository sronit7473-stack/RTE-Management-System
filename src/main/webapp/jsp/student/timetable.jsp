<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Timetable — IIC RTE Department</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root { --navy: #1B2A6B; --red: #C0392B; --gray: #F4F5F8; --muted: #6b7280; }
        body { font-family: 'Inter', sans-serif; background: var(--gray); min-height: 100vh; }

        .snav {
            background: var(--navy); height: 64px; display: flex; align-items: center;
            padding: 0 5%; gap: 0; position: sticky; top: 0; z-index: 100;
            box-shadow: 0 2px 12px rgba(0,0,0,.25);
        }
        .snav-logo { font-weight: 800; color: white; text-decoration: none; font-size: 1.05rem; margin-right: 2rem; white-space: nowrap; }
        .snav-links { display: flex; gap: .25rem; flex: 1; }
        .snav-links a {
            color: rgba(255,255,255,.65); text-decoration: none; font-size: .8rem;
            font-weight: 600; padding: 7px 13px; border-radius: 7px; transition: all .2s;
            display: flex; align-items: center; gap: .35rem; white-space: nowrap;
        }
        .snav-links a:hover, .snav-links a.active { color: white; background: rgba(255,255,255,.15); }
        .nav-badge { background: var(--red); color: white; font-size: .55rem; font-weight: 700; border-radius: 8px; padding: 1px 5px; line-height: 1.4; }
        .snav-right { display: flex; align-items: center; gap: .75rem; margin-left: auto; }
        .snav-student { font-size: .78rem; font-weight: 600; color: rgba(255,255,255,.8); white-space: nowrap; }
        .bell-wrap { position: relative; text-decoration: none; }
        .bell-btn { background: rgba(255,255,255,.1); color: white; width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1rem; transition: background .2s; }
        .bell-btn:hover { background: rgba(255,255,255,.2); }
        .bell-badge { position: absolute; top: -3px; right: -3px; background: var(--red); color: white; font-size: .55rem; font-weight: 700; border-radius: 8px; padding: 1px 4px; min-width: 16px; text-align: center; line-height: 1.4; }
        .btn-logout { background: rgba(255,255,255,.1); border: 1px solid rgba(255,255,255,.2); color: white; padding: 7px 16px; border-radius: 7px; font-size: .78rem; font-weight: 700; text-decoration: none; transition: all .2s; }
        .btn-logout:hover { background: rgba(255,255,255,.2); }

        .page-wrap { padding: 2rem 5%; }
        .page-header { margin-bottom: 1.75rem; }
        .page-title { font-size: 1.5rem; font-weight: 800; color: var(--navy); }
        .page-sub { font-size: .85rem; color: var(--muted); margin-top: .2rem; }

        /* WEEKLY GRID */
        .week-grid { display: grid; grid-template-columns: repeat(5,1fr); gap: .85rem; margin-bottom: 2rem; overflow-x: auto; }
        .day-col { background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,.07); overflow: hidden; min-width: 160px; }
        .day-header { background: var(--navy); color: white; text-align: center; padding: .7rem; font-size: .78rem; font-weight: 700; letter-spacing: .5px; text-transform: uppercase; }
        .day-body { padding: .75rem; display: flex; flex-direction: column; gap: .6rem; min-height: 120px; }
        .routine-card {
            background: #f8faff; border: 1.5px solid #e0e7ff; border-radius: 8px;
            padding: .65rem .75rem;
        }
        .rc-course { font-size: .8rem; font-weight: 700; color: var(--navy); }
        .rc-meta { font-size: .7rem; color: var(--muted); margin-top: 3px; line-height: 1.5; }
        .day-empty { text-align: center; color: #d1d5db; font-size: .75rem; padding: 1rem .5rem; }

        /* LIST TABLE */
        .card { background: white; border-radius: 14px; box-shadow: 0 2px 12px rgba(0,0,0,.07); overflow: hidden; }
        .card-head { padding: 1.1rem 1.4rem; border-bottom: 1px solid #f1f5f9; }
        .card-head-title { font-size: .82rem; font-weight: 700; color: #374151; text-transform: uppercase; letter-spacing: .4px; }
        table { width: 100%; border-collapse: collapse; }
        thead tr { background: #f8fafc; }
        th { padding: .75rem 1rem; text-align: left; font-size: .72rem; font-weight: 700; color: var(--muted); text-transform: uppercase; letter-spacing: .4px; border-bottom: 1px solid #f1f5f9; }
        td { padding: .8rem 1rem; font-size: .84rem; color: #374151; border-bottom: 1px solid #f8fafc; }
        tbody tr:last-child td { border-bottom: none; }
        tbody tr:hover td { background: #fafbff; }
        .day-pill { display: inline-block; padding: 3px 10px; border-radius: 20px; font-size: .68rem; font-weight: 700; background: #eff2ff; color: var(--navy); }

        .empty-state { text-align: center; padding: 3rem 1rem; color: var(--muted); }
        .empty-state i { font-size: 2.5rem; display: block; margin-bottom: .75rem; opacity: .35; }
        .empty-state p { font-size: .9rem; }

        /* HAMBURGER + MOBILE MENU */
        .hamburger { display: none; background: none; border: none; color: white; font-size: 1.3rem; cursor: pointer; padding: .4rem .5rem; border-radius: 6px; align-items: center; transition: background .2s; }
        .hamburger:hover { background: rgba(255,255,255,.1); }
        .mobile-menu { display: none; position: fixed; inset: 0; background: rgba(0,0,0,.55); z-index: 1000; }
        .mobile-menu.open { display: block; }
        .mobile-menu-inner { position: absolute; top: 0; left: 0; width: 270px; height: 100%; background: var(--navy); padding: 1.5rem 1rem; overflow-y: auto; box-shadow: 4px 0 20px rgba(0,0,0,.3); }
        .mobile-menu-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 1.5rem; }
        .mobile-menu-logo { color: white; font-weight: 800; font-size: 1rem; }
        .mobile-menu-close { background: none; border: none; color: rgba(255,255,255,.7); font-size: 1.2rem; cursor: pointer; padding: .3rem; border-radius: 6px; }
        .mobile-nav-links { display: flex; flex-direction: column; gap: .2rem; }
        .mobile-nav-links a { display: flex; align-items: center; gap: .6rem; padding: .65rem .75rem; color: rgba(255,255,255,.75); text-decoration: none; font-size: .85rem; font-weight: 600; border-radius: 8px; transition: all .15s; }
        .mobile-nav-links a.active, .mobile-nav-links a:hover { color: white; background: rgba(255,255,255,.15); }
        .mobile-menu-divider { height: 1px; background: rgba(255,255,255,.1); margin: 1rem 0; }
        .mobile-user-info { display: block; font-size: .75rem; color: rgba(255,255,255,.5); padding: 0 .75rem .5rem; }
        .mobile-logout-link { display: flex; align-items: center; gap: .5rem; color: rgba(255,255,255,.7); text-decoration: none; font-size: .82rem; font-weight: 600; padding: .55rem .75rem; border-radius: 8px; margin-top: .25rem; }
        .mobile-logout-link:hover { color: white; background: rgba(255,255,255,.1); }

        @media (max-width: 800px) { .week-grid { grid-template-columns: repeat(5, minmax(140px,1fr)); } }
        @media (max-width: 768px) {
            .hamburger { display: flex; }
            .snav-links { display: none !important; }
            .snav-student { display: none; }
            .page-wrap { padding: 1.25rem 4%; }
        }
        .filter-card { background: white; border-radius: 14px; box-shadow: 0 2px 10px rgba(0,0,0,.07); padding: 1.1rem 1.4rem; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 1rem; flex-wrap: wrap; }
        .filter-label { font-size: .78rem; font-weight: 700; color: #374151; white-space: nowrap; }
        .filter-select { padding: .5rem .8rem; border: 1.5px solid #e5e7eb; border-radius: 8px; font-size: .85rem; font-family: inherit; outline: none; min-width: 220px; cursor: pointer; transition: border-color .2s; }
        .filter-select:focus { border-color: var(--navy); }
        .section-prompt { background: white; border-radius: 14px; box-shadow: 0 2px 10px rgba(0,0,0,.07); padding: 4rem 2rem; text-align: center; color: var(--muted); }
        .section-prompt i { font-size: 3rem; display: block; margin-bottom: 1rem; opacity: .25; }
        .section-prompt p { font-size: .92rem; }
        .flash, .alert { position: fixed; top: 20px; right: 20px; z-index: 9999; min-width: 300px; max-width: 450px; box-shadow: 0 4px 12px rgba(0,0,0,.15); border-radius: 8px; padding: .85rem 1.2rem; font-size: .85rem; font-weight: 600; display: flex; align-items: center; gap: .5rem; animation: slideIn .3s ease; }
        .flash.success, .alert.success { background: #f0fdf4; color: #15803d; border: 1px solid #bbf7d0; }
        .flash.error, .alert.error     { background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }
        @keyframes slideIn { from { opacity: 0; transform: translateX(50px); } to { opacity: 1; transform: translateX(0); } }
    </style>
</head>
<body>

<nav class="snav">
    <a href="${pageContext.request.contextPath}/student/dashboard" class="snav-logo">IIC RTE Dept</a>
    <button class="hamburger" id="navToggle" aria-label="Menu"><i class="bi bi-list"></i></button>
    <div class="snav-links">
        <a href="${pageContext.request.contextPath}/student/dashboard"><i class="bi bi-grid-1x2"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/student/timetable" class="active"><i class="bi bi-calendar3"></i> Timetable</a>
        <a href="${pageContext.request.contextPath}/student/exams"><i class="bi bi-journal-text"></i> Exams</a>
        <a href="${pageContext.request.contextPath}/student/materials"><i class="bi bi-folder2-open"></i> Materials</a>
        <a href="${pageContext.request.contextPath}/student/notifications">
            <i class="bi bi-bell"></i> Notifications
            <c:if test="${unreadCount > 0}"><span class="nav-badge">${unreadCount}</span></c:if>
        </a>
    </div>
    <div class="snav-right">
        <span class="snav-student"><i class="bi bi-person-circle"></i> ${sessionScope.studentName}</span>
        <a href="${pageContext.request.contextPath}/student/notifications" class="bell-wrap">
            <span class="bell-btn"><i class="bi bi-bell-fill"></i></span>
            <c:if test="${unreadCount > 0}"><span class="bell-badge">${unreadCount}</span></c:if>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout logout-link">Logout</a>
    </div>
</nav>

<!-- MOBILE MENU -->
<div class="mobile-menu" id="mobileMenu">
    <div class="mobile-menu-inner">
        <div class="mobile-menu-header">
            <span class="mobile-menu-logo">IIC RTE Dept</span>
            <button class="mobile-menu-close" id="menuClose"><i class="bi bi-x-lg"></i></button>
        </div>
        <span class="mobile-user-info"><i class="bi bi-person-circle"></i> ${sessionScope.studentName}</span>
        <div class="mobile-menu-divider"></div>
        <div class="mobile-nav-links">
            <a href="${pageContext.request.contextPath}/student/dashboard"><i class="bi bi-grid-1x2"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/student/timetable" class="active"><i class="bi bi-calendar3"></i> Timetable</a>
            <a href="${pageContext.request.contextPath}/student/exams"><i class="bi bi-journal-text"></i> Exams</a>
            <a href="${pageContext.request.contextPath}/student/materials"><i class="bi bi-folder2-open"></i> Materials</a>
            <a href="${pageContext.request.contextPath}/student/notifications"><i class="bi bi-bell"></i> Notifications <c:if test="${unreadCount > 0}"><span class="nav-badge">${unreadCount}</span></c:if></a>
        </div>
        <div class="mobile-menu-divider"></div>
        <a href="${pageContext.request.contextPath}/logout" class="mobile-logout-link logout-link"><i class="bi bi-box-arrow-right"></i> Logout</a>
    </div>
</div>

<div class="page-wrap">
    <div class="page-header">
        <h1 class="page-title">Weekly Timetable</h1>
        <p class="page-sub">Your class schedule for the week</p>
    </div>

    <!-- Section Filter -->
    <div class="filter-card">
        <span class="filter-label"><i class="bi bi-funnel"></i> Section:</span>
        <form method="get" action="${pageContext.request.contextPath}/student/timetable" style="display:flex;align-items:center;gap:.75rem;flex-wrap:wrap;">
            <select name="sectionId" class="filter-select" onchange="this.form.submit()">
                <option value="">— My section —</option>
                <c:forEach var="sec" items="${sections}">
                    <option value="${sec.id}" ${selectedSection == sec.id ? 'selected' : ''}>${sec.name}</option>
                </c:forEach>
            </select>
        </form>
    </div>

    <c:choose>
    <c:when test="${selectedSection == 0}">
        <div class="section-prompt">
            <i class="bi bi-calendar3"></i>
            <p>No section assigned yet. Select a section above to view its timetable.</p>
        </div>
    </c:when>
    <c:otherwise>

    <!-- WEEKLY GRID -->
    <div class="week-grid">
        <c:forEach var="day" items="${days}">
            <div class="day-col">
                <div class="day-header">${day}</div>
                <div class="day-body">
                    <c:set var="dayRoutines" value="${byDay[day]}"/>
                    <c:choose>
                        <c:when test="${empty dayRoutines}">
                            <div class="day-empty"><i class="bi bi-dash-circle"></i><br>No classes</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="r" items="${dayRoutines}">
                                <div class="routine-card">
                                    <div class="rc-course">${r.course}</div>
                                    <div class="rc-meta">
                                        <i class="bi bi-clock"></i> ${r.time}<br>
                                        <i class="bi bi-geo-alt"></i> ${r.room}<br>
                                        <i class="bi bi-person"></i> ${r.instructor}
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- LIST TABLE -->
    <div class="card">
        <div class="card-head">
            <span class="card-head-title"><i class="bi bi-list-ul"></i> Full Schedule</span>
        </div>
        <c:choose>
            <c:when test="${empty allRoutines}">
                <div class="empty-state">
                    <i class="bi bi-calendar-x"></i>
                    <p>No routines assigned to your account yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Course</th>
                            <th>Day</th>
                            <th>Time</th>
                            <th>Room</th>
                            <th>Instructor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${allRoutines}" varStatus="s">
                            <tr>
                                <td style="color:var(--muted)">${s.count}</td>
                                <td style="font-weight:700;color:var(--navy)">${r.course}</td>
                                <td><span class="day-pill">${r.day}</span></td>
                                <td>${r.time}</td>
                                <td>${r.room}</td>
                                <td>${r.instructor}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    </c:otherwise>
    </c:choose>
</div>
<script>
setTimeout(function() {
    document.querySelectorAll('.flash, .alert').forEach(function(el) {
        el.style.transition = 'opacity 0.5s ease';
        el.style.opacity = '0';
        setTimeout(function() { el.remove(); }, 500);
    });
}, 4000);
var navToggle = document.getElementById('navToggle');
var mobileMenu = document.getElementById('mobileMenu');
var menuClose  = document.getElementById('menuClose');
if (navToggle) navToggle.addEventListener('click', function() { mobileMenu.classList.add('open'); });
if (menuClose)  menuClose.addEventListener('click', function() { mobileMenu.classList.remove('open'); });
if (mobileMenu) mobileMenu.addEventListener('click', function(e) { if (e.target === mobileMenu) mobileMenu.classList.remove('open'); });
document.querySelectorAll('.logout-link').forEach(function(el) {
    el.addEventListener('click', function(e) {
        e.preventDefault();
        if (confirm('Are you sure you want to logout?')) { window.location.href = this.href; }
    });
});
</script>
</body>
</html>
