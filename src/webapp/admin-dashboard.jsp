
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
    String role = (String) session.getAttribute("role");

    if (role == null || !"ADMIN".equalsIgnoreCase(role)) {
        response.sendRedirect(
            request.getContextPath() + "/login.jsp?error=1"
        );
        return;
    }

    String fullName = (String) session.getAttribute("fullName");
    String context = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - Online Event Registration</title>

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #FFF8EF;
    color: #342E27;
}

nav {
    background: #78815A;
    padding: 17px 7%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 12px;
}

nav a {
    color: white;
    text-decoration: none;
    margin-left: 18px;
    font-size: 14px;
}

.brand {
    font-size: 18px;
    font-weight: bold;
    color: #FFFFFF;
    font-weight: bold;
}

.container {
    width: 90%;
    max-width: 950px;
    margin: 40px auto;
}

h1 {
    color: #8E482D;
    margin-bottom: 8px;
}

.welcome {
    color: #6E6256;
    margin-bottom: 30px;
    line-height: 1.6;
}

.section-title {
    font-size: 20px;
    margin-bottom: 16px;
}

.cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 20px;
}

.card {
    background: white;
    border: 1px solid #E8DCCB;
    border-radius: 10px;
    padding: 24px;
}

.card h2 {
    font-size: 19px;
    color: #8E482D;
    margin-top: 0;
}

.card p {
    color: #6E6256;
    line-height: 1.6;
    font-size: 14px;
    min-height: 44px;
}

.button {
    display: inline-block;
    margin-top: 12px;
    padding: 11px 15px;
    background: #C7653B;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    font-size: 14px;
}

.button:hover {
    background: #8E482D;
}

footer {
    text-align: center;
    color: #6E6256;
    padding: 20px;
    font-size: 13px;
}

@media (max-width: 480px) {
    nav {
        padding: 15px 5%;
    }

    nav a {
        margin-left: 10px;
    }
}
</style>
</head>

<body>

<nav>
    <a class="brand" href="<%= context %>/admin-dashboard.jsp">
        Admin Dashboard
    </a>

    <div>
        <a href="<%= context %>/events.jsp">View Events</a>
        <a href="<%= context %>/logout">Logout</a>
    </div>
</nav>

<main class="container">
    <h1>Admin Dashboard</h1>

    <p class="welcome">
        Welcome, <%= fullName == null ? "Admin" : fullName %>.
        Manage college events from this page.
    </p>

    <h2 class="section-title">Event Management</h2>

    <div class="cards">

        <section class="card">
            <h2>Add Event</h2>
            <p>Create a college event and select its venue and capacity.</p>
            <a class="button" href="<%= context %>/admin-event-form.jsp">
                Add Event
            </a>
        </section>

        <section class="card">
            <h2>Manage Events</h2>
            <p>View listed events and access the event editing and deletion controls.</p>
            <a class="button" href="<%= context %>/admin-manage-events.jsp">
                Manage Events
            </a>
        </section>

        <section class="card">
            <h2>View Events</h2>
            <p>See the events available to students for registration.</p>
            <a class="button" href="<%= context %>/admin-view-events.jsp">
                View Events
            </a>
        </section>

    </div>
</main>

<footer>Online Event Registration System</footer>

</body>
</html>
