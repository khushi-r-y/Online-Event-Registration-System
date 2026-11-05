
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eventregistration.model.Registration" %>



<%
    String context = request.getContextPath();

    if (session.getAttribute("userId") == null) {
        response.sendRedirect(context + "/login.jsp");
        return;
    }

    String role = (String) session.getAttribute("role");

    if (!"USER".equalsIgnoreCase(role)) {
        response.sendRedirect(context + "/index.html");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Registrations | Campus Events</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #FFF8EF;
            color: #342E27;
            line-height: 1.6;
        }

        a {
            text-decoration: none;
        }

        .container {
            width: 90%;
            max-width: 1150px;
            margin: 0 auto;
        }

        /* Navigation */
        .navbar {
            background-color: #78815A;
            border-bottom: 1px solid #E8DCCB;
        }

        .nav-content {
            min-height: 72px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
        }

        .brand {
            color: #8E482D;
            font-size: 20px;
            font-weight: bold;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: #342E27;
            font-size: 14px;
            font-weight: bold;
        }

        .nav-links a:hover {
            color: #C7653B;
        }

        /* Page heading */
        .page-header {
            padding: 38px 0 25px;
        }

        .page-header h1 {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .page-header p {
            color: #6E6256;
            font-size: 14px;
        }

        .section-label {
            color: #78815A;
            font-size: 12px;
            font-weight: bold;
            letter-spacing: 1px;
            margin-bottom: 7px;
        }

        .welcome {
            margin-top: 12px;
        }

        /* Status messages */
        .message {
            padding: 12px 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .success {
            background-color: #E9EBD9;
            color: #46502F;
            border: 1px solid #C9D0B2;
        }

        .warning {
            background-color: #F8E9D9;
            color: #8E482D;
            border: 1px solid #E8C9B2;
        }

        /* Registration table */
        .registrations-section {
            padding-bottom: 55px;
        }

        .table-card {
            background-color: #FFFFFF;
            border: 1px solid #E8DCCB;
            border-radius: 10px;
            overflow: hidden;
        }

        .table-scroll {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        thead {
            background-color: #78815A;
            color: #FFFFFF;
        }

        th {
            padding: 15px 16px;
            font-size: 13px;
            font-weight: bold;
            white-space: nowrap;
        }

        td {
            padding: 15px 16px;
            border-bottom: 1px solid #EFE5D9;
            font-size: 14px;
            vertical-align: middle;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background-color: #FFFCF8;
        }

        .event-title {
            font-weight: bold;
            color: #8E482D;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            white-space: nowrap;
        }

        .status-active {
            background-color: #E9EBD9;
            color: #46502F;
        }

        .status-cancelled {
            background-color: #F3E5DC;
            color: #79513D;
        }

        /* Cancellation button */
        .cancel-button {
            background-color: #C7653B;
            color: #FFFFFF;
            border: none;
            border-radius: 5px;
            padding: 9px 12px;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
            white-space: nowrap;
        }

        .cancel-button:hover {
            background-color: #8E482D;
        }

        /* Empty state */
        .empty-state {
            padding: 35px 20px;
            text-align: center;
        }

        .empty-state h2 {
            font-size: 20px;
            margin-bottom: 8px;
        }

        .empty-state p {
            color: #6E6256;
            margin-bottom: 20px;
        }

        .primary-button {
            display: inline-block;
            background-color: #C7653B;
            color: #FFFFFF;
            border-radius: 5px;
            padding: 10px 16px;
            font-size: 14px;
            font-weight: bold;
        }

        .primary-button:hover {
            background-color: #8E482D;
        }

        /* Footer */
        .footer {
            background-color: #342E27;
            color: #FFF8EF;
            text-align: center;
            padding: 20px 0;
            font-size: 13px;
        }

        @media (max-width: 760px) {
            .nav-content {
                padding: 16px 0;
                align-items: flex-start;
                flex-direction: column;
            }

            .nav-links {
                gap: 14px;
            }

            .page-header h1 {
                font-size: 26px;
            }
        }
    </style>
</head>

<body>

    <!-- Navigation -->
    <header class="navbar">
        <div class="container nav-content">
            <a href="index.html" class="brand">Campus Events</a>

            <nav class="nav-links">
                <a href="index.html">Home</a>
                <a href="events.jsp">Browse Events</a>
                <a href="logout">Logout</a>
            </nav>
        </div>
    </header>

    <main class="container">

        <!-- Page heading -->
        <section class="page-header">
            <p class="section-label">STUDENT ACCOUNT</p>
            <h1>My Registrations</h1>

            <p>View and manage your registered events.</p>

            <p class="welcome">
                Welcome, <strong><%= session.getAttribute("fullName") %></strong>.
            </p>
        </section>

        <!-- Cancellation messages -->
        <%
            String cancellation = request.getParameter("cancellation");

            if ("SUCCESS".equals(cancellation)) {
        %>
            <div class="message success">
                Registration cancelled successfully.
            </div>
        <%
            } else if ("FAILED".equals(cancellation)) {
        %>
            <div class="message warning">
                Unable to cancel registration. It may already be cancelled.
            </div>
        <%
            }
        %>

        <!-- Registration records -->
        <section class="registrations-section">

            <%
                List<Registration> registrations =
                    (List<Registration>) request.getAttribute("registrations");

                if (registrations == null || registrations.isEmpty()) {
            %>

                <div class="table-card empty-state">
                    <h2>No Registrations Found</h2>
                    <p>You have not registered for any events yet.</p>
                    <a href="events.jsp" class="primary-button">
                        Browse Events
                    </a>
                </div>

            <%
                } else {
            %>

                <div class="table-card">
                    <div class="table-scroll">

                        <table>
                            <thead>
                                <tr>
                                    <th>Event</th>
                                    <th>Event Date</th>
                                    <th>Venue</th>
                                    <th>Registered On</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>

                            <tbody>
                                <%
                                    for (Registration registration : registrations) {
                                %>

                                    <tr>
                                        <td class="event-title">
                                            <%= registration.getEventTitle() %>
                                        </td>

                                        <td>
                                            <%= registration.getEventDate() %>
                                        </td>

                                        <td>
                                            <%= registration.getVenueName() %>
                                        </td>

                                        <td>
                                            <%= registration.getRegistrationDate() %>
                                        </td>

                                        <td>
                                            <% if ("ACTIVE".equals(registration.getStatus())) { %>
                                                <span class="status status-active">
                                                    Active
                                                </span>
                                            <% } else { %>
                                                <span class="status status-cancelled">
                                                    Cancelled
                                                </span>
                                            <% } %>
                                        </td>

                                        <td>
                                            <% if ("ACTIVE".equals(registration.getStatus())) { %>

                                                <form action="cancel-registration"
                                                      method="post"
                                                      onsubmit="return confirm('Are you sure you want to cancel this registration?');">

                                                    <input type="hidden"
                                                           name="registrationId"
                                                           value="<%= registration.getRegistrationId() %>">

                                                    <button type="submit"
                                                            class="cancel-button">
                                                        Cancel
                                                    </button>
                                                </form>

                                            <% } else { %>
                                                <span class="status status-cancelled">
                                                    Completed
                                                </span>
                                            <% } %>
                                        </td>
                                    </tr>

                                <%
                                    }
                                %>
                            </tbody>
                        </table>

                    </div>
                </div>

            <%
                }
            %>

        </section>

    </main>

    <footer class="footer">
        <div class="container">
            Online Event Registration System
        </div>
    </footer>

</body>
</html>
