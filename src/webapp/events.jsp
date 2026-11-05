
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eventregistration.dao.EventDAO" %>
<%@ page import="com.eventregistration.model.Event" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Events | Campus Events</title>

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
            max-width: 1100px;
            margin: 0 auto;
        }

        /* Navigation - matches homepage */
        .navbar {
            background-color: #78815A;
            border-bottom: 1px solid #78815A;
        }

        .nav-content {
            min-height: 72px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
        }

        .brand {
            color: #FFFFFF;
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
            color: #FFFFFF;
            font-size: 14px;
            font-weight: 600;
            transition: color 0.2s ease;
        }

        .nav-links a:hover {
            color: #F4EBDD;
        }

        .nav-links .account-button {
            background-color: #C7653B;
            color: #FFFFFF;
            padding: 9px 15px;
            border-radius: 5px;
        }

        .nav-links .account-button:hover {
            background-color: #8E482D;
            color: #FFFFFF;
        }

        /* Page heading */
        .page-header {
            padding: 42px 0 28px;
        }

        .page-header h1 {
            color: #342E27;
            font-size: 32px;
            margin-bottom: 8px;
        }

        .page-header p {
            color: #6E6256;
            font-size: 15px;
        }

        .section-label {
            color: #59613F;
            font-size: 12px;
            font-weight: bold;
            letter-spacing: 1px;
            margin-bottom: 8px;
        }

        /* Registration messages */
        .message {
            padding: 13px 16px;
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

        .error {
            background-color: #F8E3DE;
            color: #8E3028;
            border: 1px solid #E8BDB5;
        }

        /* Event cards */
        .events-section {
            padding-bottom: 55px;
        }

        .events-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 22px;
        }

        .event-card {
            background-color: #FFFFFF;
            border: 1px solid #E8DCCB;
            border-radius: 10px;
            padding: 24px;
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .event-card h2 {
            color: #8E482D;
            font-size: 21px;
            line-height: 1.4;
        }

        .event-description {
            color: #6E6256;
            font-size: 14px;
            white-space: pre-line;
        }

        .event-details {
            border-top: 1px solid #EFE5D9;
            padding-top: 14px;
            display: grid;
            gap: 10px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 14px;
            font-size: 14px;
        }

        .detail-label {
            color: #75695D;
        }

        .detail-value {
            color: #342E27;
            font-weight: bold;
            text-align: right;
            overflow-wrap: anywhere;
        }

        .event-action {
            margin-top: auto;
            padding-top: 5px;
        }

        /* Register button */
        .register-button {
            display: inline-block;
            width: 100%;
            padding: 12px 16px;
            border: none;
            border-radius: 5px;
            background-color: #C7653B;
            color: #FFFFFF;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.2s ease;
        }

        .register-button:hover {
            background-color: #8E482D;
        }

        /* Login prompt styled as an orange button */
        .login-prompt {
            display: block;
            width: 100%;
            padding: 12px 16px;
            background-color: #C7653B;
            color: #FFFFFF;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
            text-align: center;
            transition: background-color 0.2s ease;
        }

        .login-prompt:hover {
            background-color: #8E482D;
            color: #FFFFFF;
        }

        /* Empty state */
        .empty-state {
            background-color: #FFFFFF;
            border: 1px solid #E8DCCB;
            border-radius: 10px;
            padding: 35px 20px;
            text-align: center;
            color: #6E6256;
        }

        .empty-state h2 {
            color: #342E27;
            font-size: 20px;
            margin-bottom: 8px;
        }

        /* Footer */
        .footer {
            background-color: #342E27;
            color: #FFF8EF;
            padding: 20px 0;
            font-size: 13px;
            text-align: center;
        }

        /* Responsive layout */
        @media (max-width: 760px) {
            .nav-content {
                padding: 16px 0;
                align-items: flex-start;
                flex-direction: column;
            }

            .nav-links {
                gap: 14px;
            }

            .page-header {
                padding-top: 30px;
            }

            .page-header h1 {
                font-size: 27px;
            }

            .events-grid {
                grid-template-columns: 1fr;
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
                <a href="events.jsp">Events</a>

                <% if (session.getAttribute("userId") != null) { %>
                    <a href="my-registrations">My Registrations</a>
                    <a href="logout">Logout</a>
                <% } else { %>
                    <a href="login.jsp">Login</a>
                    <a href="register.jsp" class="account-button">
                        Create Account
                    </a>
                <% } %>
            </nav>

        </div>
    </header>

    <main class="container">

        <!-- Page heading -->
        <section class="page-header">
            <p class="section-label">CAMPUS EVENTS</p>
            <h1>Available Events</h1>
            <p>View event details and register for available events.</p>
        </section>

        <!-- Registration status messages -->
        <%
            String registration = request.getParameter("registration");
        %>

        <% if ("SUCCESS".equals(registration)) { %>
            <div class="message success">
                Registration successful.
            </div>

        <% } else if ("ALREADY_REGISTERED".equals(registration)) { %>
            <div class="message warning">
                You are already registered for this event.
            </div>

        <% } else if ("EVENT_FULL".equals(registration)) { %>
            <div class="message warning">
                This event has reached its maximum capacity.
            </div>

        <% } else if ("EVENT_UNAVAILABLE".equals(registration)) { %>
            <div class="message warning">
                This event is no longer available.
            </div>

        <% } else if ("ERROR".equals(registration)) { %>
            <div class="message error">
                Something went wrong. Please try again later.
            </div>
        <% } %>

        <!-- Event cards -->
        <section class="events-section">

            <%
                EventDAO dao = new EventDAO();
                List<Event> events = dao.getAllActiveEvents();

                if (events.isEmpty()) {
            %>

                <div class="empty-state">
                    <h2>No Events Available</h2>
                    <p>There are currently no active events to display.</p>
                </div>

            <%
                } else {
            %>

                <div class="events-grid">

                    <%
                        for (Event event : events) {
                    %>

                        <article class="event-card">

                            <h2><%= event.getEventTitle() %></h2>

                            <% if (event.getEventDescription() != null
                                    && !event.getEventDescription().trim().isEmpty()) { %>

                                <p class="event-description">
                                    <%= event.getEventDescription() %>
                                </p>

                            <% } %>

                            <div class="event-details">

                                <div class="detail-row">
                                    <span class="detail-label">Date</span>
                                    <span class="detail-value">
                                        <%= event.getEventDate().substring(0, 10) %>
                                    </span>
                                </div>

                                <div class="detail-row">
                                    <span class="detail-label">Venue</span>
                                    <span class="detail-value">
                                        <%= event.getVenueName() %>
                                    </span>
                                </div>

                                <div class="detail-row">
                                    <span class="detail-label">Maximum Capacity</span>
                                    <span class="detail-value">
                                        <%= event.getMaxCapacity() %> students
                                    </span>
                                </div>

                            </div>

                            <div class="event-action">

                                <% if (session.getAttribute("userId") != null) { %>

                                    <form action="register-event" method="post">
                                        <input type="hidden"
                                               name="eventId"
                                               value="<%= event.getEventId() %>">

                                        <button type="submit" class="register-button">
                                            Register for Event
                                        </button>
                                    </form>

                                <% } else { %>

                                    <a href="login.jsp" class="login-prompt">
                                        Log in to register
                                    </a>

                                <% } %>

                            </div>

                        </article>

                    <%
                        }
                    %>

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
