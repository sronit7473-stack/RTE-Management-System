<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IIC RTE Department — Home</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --navy: #1B2A6B;
            --red:  #C0392B;
            --gray: #F4F5F8;
            --muted: #6b7280;
            --white: #ffffff;
        }

        body { font-family: 'Inter', sans-serif; color: #111827; line-height: 1.6; }

        .container { max-width: 1200px; margin: 0 auto; padding: 0 5%; }

        /* ── Fade-in on scroll ── */
        .fade-in { opacity: 0; transform: translateY(24px); transition: opacity .65s ease, transform .65s ease; }
        .fade-in.visible { opacity: 1; transform: translateY(0); }

        /* ══════════════════════════════════════
           NAVBAR
        ══════════════════════════════════════ */
        .navbar {
            position: fixed; top: 0; width: 100%;
            background: var(--white);
            display: flex; align-items: center; justify-content: space-between;
            padding: 0 5%; height: 68px; z-index: 1000;
            transition: box-shadow .3s ease;
        }
        .navbar.scrolled { box-shadow: 0 2px 24px rgba(0,0,0,.08); }
        .nav-logo { font-weight: 800; font-size: 1.2rem; color: var(--navy); text-decoration: none; letter-spacing: -.3px; }
        .nav-links { display: flex; gap: 2.5rem; list-style: none; }
        .nav-links a { text-decoration: none; color: #374151; font-weight: 500; font-size: .95rem; padding-bottom: 3px; transition: color .2s; }
        .nav-links a.active { color: var(--navy); border-bottom: 2.5px solid var(--navy); font-weight: 600; }
        .nav-links a:hover:not(.active) { color: var(--navy); }
        .btn-login {
            padding: 9px 22px; border: 2px solid var(--navy); color: var(--navy);
            background: transparent; border-radius: 7px; font-weight: 600; font-size: .9rem;
            text-decoration: none; transition: all .25s;
        }
        .btn-login:hover { background: var(--navy); color: white; }

        /* ══════════════════════════════════════
           HERO
        ══════════════════════════════════════ */
        .hero { background: var(--gray); min-height: 100vh; display: flex; align-items: center; padding-top: 68px; }
        .hero-grid {
            display: grid; grid-template-columns: 1fr 1fr;
            gap: 5rem; align-items: center; padding: 5rem 0;
        }
        .hero-heading { font-size: 3rem; font-weight: 800; color: var(--navy); line-height: 1.15; letter-spacing: -1px; margin-bottom: 1.25rem; }
        .hero-sub { color: var(--muted); font-size: 1.05rem; line-height: 1.8; margin-bottom: 2rem; }
        .hero-buttons { display: flex; gap: 1rem; flex-wrap: wrap; }

        .btn-red {
            padding: 13px 28px; background: var(--red); color: white;
            border: none; border-radius: 8px; font-weight: 600; font-size: .95rem;
            text-decoration: none; transition: all .25s; display: inline-block;
        }
        .btn-red:hover { background: #a93226; transform: translateY(-2px); box-shadow: 0 6px 18px rgba(192,57,43,.3); }
        .btn-outline {
            padding: 13px 28px; background: transparent; color: var(--navy);
            border: 2px solid var(--navy); border-radius: 8px; font-weight: 600; font-size: .95rem;
            text-decoration: none; transition: all .25s; display: inline-block;
        }
        .btn-outline:hover { background: var(--navy); color: white; transform: translateY(-2px); }

        /* — Laptop mockup — */
        .laptop-wrap { display: flex; flex-direction: column; align-items: center; animation: float 5s ease-in-out infinite; }
        @keyframes float { 0%,100%{transform:translateY(0)} 50%{transform:translateY(-10px)} }

        .laptop-body {
            width: 100%; background: #e2e8f0;
            border: 8px solid #94a3b8; border-bottom: none;
            border-radius: 14px 14px 0 0; padding: 8px 8px 0;
            box-shadow: 0 30px 60px rgba(0,0,0,.18);
        }
        .l-notch { width: 10px; height: 10px; background: #64748b; border-radius: 50%; margin: 0 auto 6px; }
        .l-screen { background: white; border-radius: 4px; overflow: hidden; }
        .l-topbar {
            background: var(--navy); padding: 7px 12px;
            display: flex; align-items: center; gap: 6px;
        }
        .l-dot { width: 8px; height: 8px; border-radius: 50%; }
        .ld-r{background:#ef4444} .ld-y{background:#f59e0b} .ld-g{background:#22c55e}
        .l-tab { color: rgba(255,255,255,.6); font-size: .55rem; margin-left: 8px; font-weight: 500; }
        .l-body { display: grid; grid-template-columns: 72px 1fr; min-height: 195px; }
        .l-sidebar { background: #f8fafc; padding: 8px 6px; border-right: 1px solid #e2e8f0; }
        .l-si { height: 6px; background: #cbd5e1; border-radius: 3px; margin-bottom: 8px; }
        .l-si.on { background: var(--navy); width: 65%; }
        .l-main { padding: 10px; }
        .l-month { font-size: .55rem; font-weight: 700; color: var(--navy); display: flex; justify-content: space-between; margin-bottom: 5px; }
        .cal { display: grid; grid-template-columns: repeat(7,1fr); gap: 2px; font-size: .48rem; text-align: center; }
        .cal-h { color: var(--muted); font-weight: 600; padding: 2px; }
        .cal-d { padding: 3px 1px; border-radius: 3px; color: #374151; }
        .cal-d.t { background: var(--red); color: white; font-weight: 700; }
        .cal-d.ev { background: #dbeafe; color: var(--navy); font-weight: 600; }
        .cal-d.g { color: #d1d5db; }
        .ev-bar { margin-top: 6px; padding: 4px 6px; border-radius: 4px; font-size: .48rem; font-weight: 600; margin-bottom: 3px; }
        .ev-r { background: #fee2e2; color: var(--red); }
        .ev-b { background: #dbeafe; color: var(--navy); }
        .laptop-hinge { height: 6px; background: linear-gradient(#94a3b8,#cbd5e1); width: 102%; border-radius: 0 0 2px 2px; }
        .laptop-base { width: 120%; height: 16px; background: linear-gradient(#cbd5e1,#e2e8f0); border-radius: 0 0 30px 30px; box-shadow: 0 4px 10px rgba(0,0,0,.1); }

        /* ══════════════════════════════════════
           STATS
        ══════════════════════════════════════ */
        .stats { background: var(--white); padding: 5rem 0; }
        .stats-grid { display: grid; grid-template-columns: repeat(4,1fr); gap: 1.5rem; }
        .stat-card {
            background: var(--white); border-radius: 14px; padding: 2rem 1.5rem;
            text-align: center; box-shadow: 0 4px 20px rgba(0,0,0,.06);
            border: 1px solid #f1f5f9; transition: transform .2s, box-shadow .2s;
        }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 10px 32px rgba(0,0,0,.1); }
        .stat-icon { font-size: 2rem; color: var(--navy); margin-bottom: .75rem; }
        .stat-num { font-size: 2.5rem; font-weight: 800; color: var(--navy); line-height: 1; margin-bottom: .4rem; }
        .stat-lbl { color: var(--muted); font-size: .875rem; font-weight: 500; }

        /* ══════════════════════════════════════
           NOTICES
        ══════════════════════════════════════ */
        .notices { background: var(--gray); padding: 5rem 0; }
        .notices-hdr { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 2.5rem; }
        .sec-badge { font-size: .72rem; font-weight: 700; color: var(--red); letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: .4rem; }
        .sec-title { font-size: 1.75rem; font-weight: 700; color: var(--navy); }
        .view-all { color: var(--navy); font-weight: 600; text-decoration: none; font-size: .875rem; transition: color .2s; white-space: nowrap; }
        .view-all:hover { color: var(--red); }
        .notices-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: 1.5rem; }

        .notice-card {
            background: var(--white); border-radius: 12px; padding: 1.5rem;
            border-left: 4px solid; box-shadow: 0 2px 12px rgba(0,0,0,.05);
            transition: transform .2s, box-shadow .2s;
            display: flex; flex-direction: column;
        }
        .notice-card:hover { transform: translateY(-4px); box-shadow: 0 8px 24px rgba(0,0,0,.1); }
        .bl-urgent  { border-left-color: var(--red); }
        .bl-academic{ border-left-color: var(--navy); }
        .bl-general { border-left-color: #9ca3af; }

        .notice-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: .75rem; }
        .badge-urgent  { background: var(--red);   color: white;   padding: 3px 10px; border-radius: 4px; font-size: .68rem; font-weight: 700; letter-spacing: .5px; }
        .badge-academic{ background: var(--navy);  color: white;   padding: 3px 10px; border-radius: 4px; font-size: .68rem; font-weight: 700; }
        .badge-general { background: #f3f4f6;      color: #374151; padding: 3px 10px; border-radius: 4px; font-size: .68rem; font-weight: 700; }
        .notice-date { font-size: .78rem; color: var(--muted); }
        .notice-title { font-size: 1rem; font-weight: 700; color: #111827; margin-bottom: .5rem; line-height: 1.4; }
        .notice-preview {
            font-size: .875rem; color: var(--muted); line-height: 1.6; flex: 1; margin-bottom: 1rem;
            display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;
        }
        .notice-link { color: var(--navy); font-size: .875rem; font-weight: 600; text-decoration: none; transition: color .2s; }
        .notice-link:hover { color: var(--red); }
        .no-notices {
            grid-column: 1/-1; text-align: center; padding: 3.5rem;
            background: var(--white); border-radius: 12px; color: var(--muted); font-size: 1rem;
        }

        /* ══════════════════════════════════════
           DESIGNED FOR EVERY USER
        ══════════════════════════════════════ */
        .users { background: var(--navy); padding: 5rem 0; }
        .users-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 5rem; align-items: center; }
        .users-title { font-size: 2.25rem; font-weight: 800; color: white; margin-bottom: 1rem; letter-spacing: -.5px; }
        .users-sub { color: rgba(255,255,255,.7); line-height: 1.8; margin-bottom: 2rem; }
        .user-rows { display: flex; flex-direction: column; gap: 1.25rem; }
        .user-row { display: flex; align-items: flex-start; gap: 1rem; }
        .user-icon {
            width: 44px; height: 44px; flex-shrink: 0;
            background: rgba(255,255,255,.12); border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.2rem; color: white;
        }
        .user-role { font-weight: 700; color: white; font-size: .975rem; margin-bottom: 3px; }
        .user-desc { color: rgba(255,255,255,.65); font-size: .875rem; line-height: 1.55; }

        /* — Monitor mockup — */
        .monitor-wrap { display: flex; flex-direction: column; align-items: center; animation: float 6s ease-in-out infinite; animation-delay: .5s; }
        .mon-screen {
            width: 100%; background: #0f172a;
            border: 6px solid #1e293b; border-radius: 12px 12px 0 0;
            padding: 12px; box-shadow: 0 0 0 1px #334155, 0 30px 60px rgba(0,0,0,.5);
        }
        .mon-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; padding-bottom: 8px; border-bottom: 1px solid #1e293b; }
        .mon-ttl { color: #94a3b8; font-size: .5rem; font-weight: 600; letter-spacing: .5px; }
        .mon-dots { display: flex; gap: 4px; }
        .mon-dot { width: 6px; height: 6px; border-radius: 50%; background: #334155; }
        .mon-cards { display: grid; grid-template-columns: 1fr 1fr; gap: 6px; margin-bottom: 6px; }
        .mon-card { background: #1e293b; border-radius: 6px; padding: 8px; }
        .mc-label { font-size: .42rem; color: #64748b; font-weight: 600; letter-spacing: .5px; margin-bottom: 3px; text-transform: uppercase; }
        .mc-value { font-size: .95rem; font-weight: 800; color: white; }
        .mc-value.accent { color: #22c55e; }
        .mon-chart { background: #1e293b; border-radius: 6px; padding: 8px; }
        .chart-label { font-size: .4rem; color: #64748b; font-weight: 600; letter-spacing: .5px; margin-bottom: 6px; text-transform: uppercase; }
        .bars { display: flex; align-items: flex-end; gap: 4px; height: 52px; }
        .bar { flex: 1; border-radius: 3px 3px 0 0; }
        .b1{height:60%;background:#6366f1} .b2{height:82%;background:#3b82f6}
        .b3{height:48%;background:#6366f1} .b4{height:92%;background:#C0392B}
        .b5{height:70%;background:#3b82f6} .b6{height:44%;background:#6366f1}
        .b7{height:86%;background:#22c55e}
        .mon-neck { width: 10%; height: 18px; background: #1e293b; }
        .mon-stand { width: 40%; height: 8px; background: #1e293b; border-radius: 0 0 8px 8px; }

        /* ══════════════════════════════════════
           FOOTER
        ══════════════════════════════════════ */
        .footer { background: var(--navy); color: white; padding: 4.5rem 0 0; }
        .footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 3rem; padding-bottom: 3rem; }
        .footer-brand { font-weight: 700; font-size: 1.05rem; margin-bottom: .75rem; }
        .footer-col p { color: rgba(255,255,255,.6); font-size: .85rem; margin-bottom: .4rem; line-height: 1.6; }
        .footer-heading { font-size: .72rem; font-weight: 700; letter-spacing: 1.5px; color: rgba(255,255,255,.45); margin-bottom: 1rem; text-transform: uppercase; }
        .footer-col ul { list-style: none; display: flex; flex-direction: column; gap: .6rem; }
        .footer-col a { color: rgba(255,255,255,.7); text-decoration: none; font-size: .875rem; transition: color .2s; }
        .footer-col a:hover { color: white; }
        .social-row { display: flex; gap: .75rem; margin-top: .25rem; }
        .social-btn {
            width: 40px; height: 40px; background: rgba(255,255,255,.1); border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: white; text-decoration: none; font-size: 1.1rem; transition: background .2s;
        }
        .social-btn:hover { background: rgba(255,255,255,.22); }
        .footer-bottom { border-top: 1px solid rgba(255,255,255,.1); padding: 1.25rem 0; }
        .footer-bottom-links { display: flex; justify-content: space-between; align-items: center; }
        .footer-bottom-links a { color: rgba(255,255,255,.4); font-size: .72rem; text-decoration: none; font-weight: 600; letter-spacing: .5px; transition: color .2s; }
        .footer-bottom-links a:hover { color: white; }

        /* ══════════════════════════════════════
           RESPONSIVE
        ══════════════════════════════════════ */
        @media (max-width: 1024px) {
            .hero-heading { font-size: 2.4rem; }
            .stats-grid { grid-template-columns: repeat(2,1fr); }
            .footer-grid { grid-template-columns: 1fr 1fr; gap: 2rem; }
        }
        @media (max-width: 768px) {
            .nav-links { display: none; }
            .hero-grid { grid-template-columns: 1fr; gap: 2.5rem; text-align: center; }
            .hero-heading { font-size: 2rem; }
            .hero-buttons { justify-content: center; }
            .hero-right { order: -1; max-width: 340px; margin: 0 auto; }
            .notices-grid { grid-template-columns: 1fr; }
            .notices-hdr { flex-direction: column; align-items: flex-start; gap: .75rem; }
            .users-grid { grid-template-columns: 1fr; }
            .monitor-wrap { display: none; }
            .footer-grid { grid-template-columns: 1fr; gap: 2rem; }
            .footer-bottom-links { flex-direction: column; gap: .5rem; text-align: center; }
        }
        @media (max-width: 480px) {
            .stats-grid { grid-template-columns: 1fr; }
            .hero-heading { font-size: 1.75rem; }
        }
    </style>
</head>
<body>

<!-- ══════════════ NAVBAR ══════════════ -->
<nav class="navbar" id="navbar">
    <a href="${pageContext.request.contextPath}/home" class="nav-logo">IIC RTE Dept</a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/home" class="active">Home</a></li>
        <li><a href="#">Notices</a></li>
        <li><a href="#">Contact</a></li>
    </ul>
    <a href="${pageContext.request.contextPath}/login" class="btn-login">Login</a>
</nav>

<!-- ══════════════ HERO ══════════════ -->
<section class="hero fade-in" id="hero">
    <div class="container">
        <div class="hero-grid">
            <div class="hero-left">
                <h1 class="hero-heading">Efficiency in Academic Management</h1>
                <p class="hero-sub">A centralized ecosystem for the RTE Department of Itahari International College.
                    Streamlining routines, exam schedules, and learning materials into a single,
                    high-performance platform for academic excellence.</p>
                <div class="hero-buttons">
                    <a href="${pageContext.request.contextPath}/student" class="btn-red">View Routines</a>
                    <a href="#" class="btn-outline">Department Info</a>
                </div>
            </div>
            <div class="hero-right">
                <!-- CSS Laptop Mockup -->
                <div class="laptop-wrap">
                    <div class="laptop-body">
                        <div class="l-notch"></div>
                        <div class="l-screen">
                            <div class="l-topbar">
                                <span class="l-dot ld-r"></span>
                                <span class="l-dot ld-y"></span>
                                <span class="l-dot ld-g"></span>
                                <span class="l-tab">RTE Academic Calendar</span>
                            </div>
                            <div class="l-body">
                                <div class="l-sidebar">
                                    <div class="l-si on"></div>
                                    <div class="l-si"></div>
                                    <div class="l-si"></div>
                                    <div class="l-si"></div>
                                    <div class="l-si"></div>
                                </div>
                                <div class="l-main">
                                    <div class="l-month"><span>May 2026</span><span style="color:var(--muted)">▸</span></div>
                                    <div class="cal">
                                        <div class="cal-h">Su</div><div class="cal-h">Mo</div><div class="cal-h">Tu</div>
                                        <div class="cal-h">We</div><div class="cal-h">Th</div><div class="cal-h">Fr</div><div class="cal-h">Sa</div>
                                        <div class="cal-d g">27</div><div class="cal-d g">28</div><div class="cal-d g">29</div>
                                        <div class="cal-d g">30</div><div class="cal-d">1</div><div class="cal-d ev">2</div><div class="cal-d">3</div>
                                        <div class="cal-d">4</div><div class="cal-d">5</div><div class="cal-d ev">6</div>
                                        <div class="cal-d">7</div><div class="cal-d">8</div><div class="cal-d">9</div><div class="cal-d">10</div>
                                        <div class="cal-d">11</div><div class="cal-d">12</div><div class="cal-d">13</div>
                                        <div class="cal-d">14</div><div class="cal-d ev">15</div><div class="cal-d t">16</div><div class="cal-d">17</div>
                                        <div class="cal-d">18</div><div class="cal-d">19</div><div class="cal-d">20</div>
                                        <div class="cal-d ev">21</div><div class="cal-d">22</div><div class="cal-d">23</div><div class="cal-d">24</div>
                                        <div class="cal-d">25</div><div class="cal-d">26</div><div class="cal-d ev">27</div>
                                        <div class="cal-d">28</div><div class="cal-d">29</div><div class="cal-d">30</div><div class="cal-d">31</div>
                                    </div>
                                    <div class="ev-bar ev-r">📌 Exam Schedule Released</div>
                                    <div class="ev-bar ev-b">📚 Mid-Term Week</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="laptop-hinge"></div>
                    <div class="laptop-base"></div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ══════════════ STATS ══════════════ -->
<section class="stats fade-in">
    <div class="container">
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon"><i class="bi bi-people-fill"></i></div>
                <div class="stat-num">${studentCount}</div>
                <div class="stat-lbl">Active Students</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="bi bi-book-fill"></i></div>
                <div class="stat-num">${courseCount}</div>
                <div class="stat-lbl">Courses Managed</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="bi bi-clock-fill"></i></div>
                <div class="stat-num">24/7</div>
                <div class="stat-lbl">Routine Access</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="bi bi-check-circle-fill"></i></div>
                <div class="stat-num">99.9%</div>
                <div class="stat-lbl">Accuracy Rate</div>
            </div>
        </div>
    </div>
</section>

<!-- ══════════════ NOTICES ══════════════ -->
<section class="notices fade-in">
    <div class="container">
        <div class="notices-hdr">
            <div>
                <div class="sec-badge">Department Updates</div>
                <h2 class="sec-title">Latest News &amp; Notices</h2>
            </div>
            <a href="#" class="view-all">View All Notices →</a>
        </div>
        <div class="notices-grid">
            <c:choose>
                <c:when test="${empty notices}">
                    <div class="no-notices">
                        <i class="bi bi-megaphone" style="font-size:2rem;display:block;margin-bottom:.75rem;opacity:.4"></i>
                        No notices available at the moment.
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="n" items="${notices}">
                        <c:set var="cat" value="${n.category}" />
                        <div class="notice-card
                            <c:choose>
                                <c:when test="${cat == 'URGENT'}">bl-urgent</c:when>
                                <c:when test="${cat == 'ACADEMIC'}">bl-academic</c:when>
                                <c:otherwise>bl-general</c:otherwise>
                            </c:choose>">
                            <div class="notice-top">
                                <c:choose>
                                    <c:when test="${cat == 'URGENT'}"><span class="badge-urgent">URGENT</span></c:when>
                                    <c:when test="${cat == 'ACADEMIC'}"><span class="badge-academic">ACADEMIC</span></c:when>
                                    <c:otherwise><span class="badge-general">GENERAL</span></c:otherwise>
                                </c:choose>
                                <span class="notice-date">${n.formattedDate}</span>
                            </div>
                            <h3 class="notice-title"><c:out value="${n.title}" /></h3>
                            <p class="notice-preview"><c:out value="${n.content}" /></p>
                            <a href="#" class="notice-link">
                                <c:choose>
                                    <c:when test="${cat == 'URGENT'}">Read Full PDF ↗</c:when>
                                    <c:when test="${cat == 'ACADEMIC'}">View Dashboard ↗</c:when>
                                    <c:otherwise>Add to Calendar ↗</c:otherwise>
                                </c:choose>
                            </a>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>

<!-- ══════════════ DESIGNED FOR EVERY USER ══════════════ -->
<section class="users fade-in">
    <div class="container">
        <div class="users-grid">
            <div class="users-left">
                <h2 class="users-title">Designed for Every User</h2>
                <p class="users-sub">The RTE management portal provides specialized interfaces tailored to the needs
                    of students, faculty, and administrative staff. Experience academic workflows redefined.</p>
                <div class="user-rows">
                    <div class="user-row">
                        <div class="user-icon"><i class="bi bi-mortarboard-fill"></i></div>
                        <div>
                            <div class="user-role">Students</div>
                            <div class="user-desc">Access routines, download materials, and track attendance.</div>
                        </div>
                    </div>
                    <div class="user-row">
                        <div class="user-icon"><i class="bi bi-pin-map-fill"></i></div>
                        <div>
                            <div class="user-role">Faculty</div>
                            <div class="user-desc">Manage class logs, upload resources, and monitor student performance.</div>
                        </div>
                    </div>
                    <div class="user-row">
                        <div class="user-icon"><i class="bi bi-gear-fill"></i></div>
                        <div>
                            <div class="user-role">Admin</div>
                            <div class="user-desc">Centralized control over scheduling, exams, and departmental notices.</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="users-right">
                <!-- CSS Monitor Mockup -->
                <div class="monitor-wrap">
                    <div class="mon-screen">
                        <div class="mon-bar">
                            <span class="mon-ttl">RTE ANALYTICS DASHBOARD</span>
                            <div class="mon-dots">
                                <span class="mon-dot"></span>
                                <span class="mon-dot"></span>
                                <span class="mon-dot"></span>
                            </div>
                        </div>
                        <div class="mon-cards">
                            <div class="mon-card">
                                <div class="mc-label">Total Students</div>
                                <div class="mc-value">${studentCount}</div>
                            </div>
                            <div class="mon-card">
                                <div class="mc-label">Pass Rate</div>
                                <div class="mc-value accent">94.2%</div>
                            </div>
                            <div class="mon-card">
                                <div class="mc-label">Courses</div>
                                <div class="mc-value">${courseCount}</div>
                            </div>
                            <div class="mon-card">
                                <div class="mc-label">Attendance</div>
                                <div class="mc-value accent">88.5%</div>
                            </div>
                        </div>
                        <div class="mon-chart">
                            <div class="chart-label">Monthly Enrollment Trend</div>
                            <div class="bars">
                                <div class="bar b1"></div>
                                <div class="bar b2"></div>
                                <div class="bar b3"></div>
                                <div class="bar b4"></div>
                                <div class="bar b5"></div>
                                <div class="bar b6"></div>
                                <div class="bar b7"></div>
                            </div>
                        </div>
                    </div>
                    <div class="mon-neck"></div>
                    <div class="mon-stand"></div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ══════════════ FOOTER ══════════════ -->
<footer class="footer">
    <div class="container">
        <div class="footer-grid">
            <div class="footer-col">
                <div class="footer-brand">Itahari International College</div>
                <p>Sundharharaicha-4, Morang, Nepal</p>
                <p>Department of Routine &amp; Class Management (RTE)</p>
                <p>Contact: +977-21-400000</p>
            </div>
            <div class="footer-col">
                <div class="footer-heading">Quick Links</div>
                <ul>
                    <li><a href="#">Academic Calendar</a></li>
                    <li><a href="#">Library Portal</a></li>
                    <li><a href="#">Student Portal</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <div class="footer-heading">Support</div>
                <ul>
                    <li><a href="#">IT Helpdesk</a></li>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <div class="footer-heading">Social</div>
                <div class="social-row">
                    <a href="#" class="social-btn"><i class="bi bi-twitter-x"></i></a>
                    <a href="#" class="social-btn"><i class="bi bi-envelope-fill"></i></a>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <div class="container">
            <div class="footer-bottom-links">
                <a href="#">Terms of Service</a>
                <a href="#">Site Map</a>
                <a href="#">Accessibility</a>
            </div>
        </div>
    </div>
</footer>

<script>
    // Navbar shadow on scroll
    const navbar = document.getElementById('navbar');
    window.addEventListener('scroll', () => {
        navbar.classList.toggle('scrolled', window.scrollY > 10);
    });

    // Fade-in on viewport entry
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
    }, { threshold: 0.1 });
    document.querySelectorAll('.fade-in').forEach(el => observer.observe(el));
</script>

</body>
</html>
