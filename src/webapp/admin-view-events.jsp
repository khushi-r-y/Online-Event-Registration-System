```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eventregistration.dao.EventDAO" %>
<%@ page import="com.eventregistration.model.Event" %>

<%
    String role = (String) session.getAttribute("role");

    if (role == null || !"ADMIN".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=1");
        return;
    }

    String context = request.getContextPath();
    List<Event> events = new EventDAO().getAllActiveEvents();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Events | Admin</title>

    <style>
        * { box-sizing: border-box; }

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
            flex-wrap: wrap;
            gap: 12px;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin-left: 16px;
        }

        .brand { font-weight: bold; }

        .container {
            width: 92%;
            max-width: 1100px;
            margin: 38px auto;
        }

        h1 { color: #8E482D; }

        .subtitle {
            color: #6E6256;
            line-height: 1.6;
        }

        .table-wrap {
            overflow-x: auto;
            background: white;
            border: 1px solid #E8DCCB;
            border-radius: 10px;
            margin-top: 22px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px;
        }

        th, td {
            padding: 14px 12px;
            border-bottom: 1px solid #E8DCCB;
            text-align: left;
            font-size: 14px;
        }

        th { background: #F4EBDD; }

        .empty {
            background: white;
            border: 1px solid #E8DCCB;
            border-radius: 10px;
            padding: 24px;
            margin-top: 22px;
        }

        .back {
            display: inline-block;
            margin-top: 22px;
            color: #8E482D;
            text-decoration: none;
        }

        @media (max-width: 500px) {
            nav { padding: 15px 5%; }
            nav a { margin-left: 8px; }
        }
    </style>
</head>

<body>
    <nav>
        <a class="brand" href="<%= context %>/admin-dashboard.jsp">
            Admin Dashboard
        </a>

        <div>
            <a href="<%= context %>/admin-manage-events.jsp">Manage Events</a>
            <a href="<%= context %>/logout">Logout</a>
        </div>
    </nav>

    <main class="container">
        <h1>View Events</h1>
        <p class="subtitle">
            View the events currently available in the system.
        </p>

        <% if (events.isEmpty()) { %>
            <div class="empty">No active events are available.</div>
        <% } else { %>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>Event Name</th>
                            <th>Date</th>
                            <th>Venue</th>
                            <th>Capacity</th>
                        </tr>
                    </thead>

                    <tbody>
                        <% for (Event event : events) { %>
                            <tr>
                                <td><%= event.getEventTitle() %></td>
                                <td>
                                    <%= event.getEventDate() == null ? ""
                                        : event.getEventDate().substring(0, 10) %>
                                </td>
                                <td><%= event.getVenueName() %></td>
                                <td><%= event.getMaxCapacity() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>

        <a class="back" href="<%= context %>/admin-dashboard.jsp">
            &larr; Back to Dashboard
        </a>
    </main>
</body>
</html>
```