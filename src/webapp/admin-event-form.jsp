<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.eventregistration.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Event - Online Event Registration</title>

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
    }

    .container {
        width: 90%;
        max-width: 650px;
        margin: 38px auto;
        padding: 32px;
        background: white;
        border: 1px solid #E8DCCB;
        border-radius: 12px;
    }

    h1 {
        margin: 0 0 10px;
        color: #8E482D;
        font-size: 28px;
    }

    .description {
        margin-bottom: 26px;
        color: #6E6256;
        line-height: 1.6;
    }

    .success {
        padding: 12px 14px;
        margin-bottom: 20px;
        background: #EDF0E7;
        color: #465333;
        border: 1px solid #D8DFC9;
        border-radius: 6px;
    }

    .error {
        padding: 12px 14px;
        margin-bottom: 20px;
        background: #FFF0E7;
        color: #8E482D;
        border-radius: 6px;
    }

    label {
        display: block;
        margin: 18px 0 7px;
        font-size: 14px;
        font-weight: bold;
    }

    input, textarea, select {
        display: block;
        width: 100%;
        padding: 12px;
        font-family: inherit;
        font-size: 15px;
        color: #342E27;
        background: #FFFCF8;
        border: 1px solid #D8CBBB;
        border-radius: 6px;
    }

    textarea {
        min-height: 110px;
        resize: vertical;
    }

    input:focus, textarea:focus, select:focus {
        outline: 2px solid #C7653B;
        border-color: transparent;
    }

    button {
        width: 100%;
        margin-top: 26px;
        padding: 13px;
        background: #C7653B;
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 15px;
        font-weight: bold;
        cursor: pointer;
    }

    button:hover {
        background: #8E482D;
    }

    .back-link {
        display: inline-block;
        margin-top: 20px;
        color: #8E482D;
        text-decoration: none;
        font-size: 14px;
    }

    footer {
        padding: 15px;
        text-align: center;
        color: #6E6256;
        font-size: 13px;
    }

    @media (max-width: 480px) {
        .container {
            padding: 23px;
            margin: 25px auto;
        }

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
    <a class="brand" href="index.html">Online Event Registration</a>
    <div>
        <a href="index.html">Home</a>
        <a href="events.jsp">Events</a>
        <a href="logout">Logout</a>
    </div>
</nav>

<div class="container">
    <h1>Add a New Event</h1>
    <p class="description">
        Enter the event details and select a venue.
    </p>

    <% if ("1".equals(request.getParameter("success"))) { %>
        <div class="success">Event added successfully.</div>
    <% } %>

    <% if ("1".equals(request.getParameter("error"))) { %>
        <div class="error">
            The event could not be added. Please check the details and try again.
        </div>
    <% } %>
    <% if ("pastDate".equals(request.getParameter("error"))) { %>
    <div class="notice">
        Past dates are not allowed. Please select today or a future date.
    </div>
<% } %>

    <form action="add-event" method="post">

        <label for="eventTitle">Event Title</label>
        <input type="text" id="eventTitle" name="eventTitle"
               maxlength="150" required>

        <label for="eventDescription">Description</label>
        <textarea id="eventDescription" name="eventDescription"
                  rows="4" maxlength="1000"></textarea>

        <label for="eventDate">Event Date</label>
        <input type="date" name="eventDate" id="eventDate" required>

        <label for="venueId">Venue</label>
        <select id="venueId" name="venueId" required>
            <option value="">-- Select Venue --</option>

            <%
                String venueSql =
                    "SELECT VENUE_ID, VENUE_NAME FROM OERS_VENUES ORDER BY VENUE_ID";

                try (Connection con = DBConnection.getConnection();
                     PreparedStatement stmt = con.prepareStatement(venueSql);
                     ResultSet rs = stmt.executeQuery()) {

                    while (rs.next()) {
            %>
                <option value="<%= rs.getInt("VENUE_ID") %>">
                    <%= rs.getString("VENUE_NAME") %>
                </option>
            <%
                    }
                } catch (Exception e) {
                    application.log("Unable to load event venues.", e);
            %>
                <option value="" disabled>Unable to load venues</option>
            <%
                }
            %>
        </select>

        <label for="maxCapacity">Maximum Capacity</label>
        <input type="number" id="maxCapacity" name="maxCapacity"
               min="1" required>

        <button type="submit">Add Event</button>
    </form>

    <a class="back-link" href="admin-dashboard.jsp">← Back to Events</a>
</div>

<footer>Online Event Registration System</footer>
<script>
    const eventDate = document.getElementById("eventDate");

    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, "0");
    const day = String(today.getDate()).padStart(2, "0");

    eventDate.min = `${year}-${month}-${day}`;
</script>
</body>
</html>
