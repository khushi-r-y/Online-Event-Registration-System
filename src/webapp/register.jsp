<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
    <%
    String context = request.getContextPath();
    String selectedRole = request.getParameter("role");

    if (!"ADMIN".equals(selectedRole)) {
        selectedRole = "USER";
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Registration</title>

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
        max-width: 460px;
        margin: 45px auto;
        padding: 32px;
        background: white;
        border: 1px solid #E8DCCB;
        border-radius: 12px;
    }

    h1 {
        margin-top: 0;
        color: #8E482D;
        font-size: 27px;
    }

    .description {
        color: #6E6256;
        line-height: 1.6;
        margin-bottom: 25px;
    }

    label {
        display: block;
        margin: 17px 0 7px;
        font-size: 14px;
        font-weight: bold;
    }

    input {
        width: 100%;
        padding: 12px;
        border: 1px solid #D8CBBB;
        border-radius: 6px;
        font-size: 15px;
        background: #FFFCF8;
    }

    input:focus {
        outline: 2px solid #C7653B;
        border-color: transparent;
    }

    button {
        width: 100%;
        margin-top: 24px;
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

    .message {
        padding: 10px;
        border-radius: 6px;
        background: #FFF0E7;
        color: #8E482D;
        font-size: 14px;
    }

    .links {
        text-align: center;
        margin-top: 22px;
        font-size: 14px;
        line-height: 2;
    }

    .links a {
        color: #8E482D;
        font-weight: bold;
        text-decoration: none;
    }

    footer {
        text-align: center;
        color: #6E6256;
        font-size: 13px;
        padding: 15px;
    }

    @media (max-width: 480px) {
        .container {
            padding: 24px;
            margin: 28px auto;
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
        <a href="login.jsp">Login</a>
    </div>
</nav>

<div class="container">
  	<h1>
    <%= "ADMIN".equals(selectedRole)
        ? "Create Admin Account"
        : "Create Student Account" %>
</h1>
    <p class="description">
        Register to participate in college events.
    </p>

    <% if ("1".equals(request.getParameter("error"))) { %>
        <p class="message">
            Registration failed. Check your details or try another email address.
        </p>
    <% } %>

    <form action="<%= context %>/register" method="post">
    <input type="hidden" name="role"
           value="<%= selectedRole %>">
        <label for="fullName">Full Name</label>
        <input type="text" id="fullName" name="fullName"
               autocomplete="name" required>

        <label for="email">Email</label>
        <input type="email" id="email" name="email"
               autocomplete="email" required>

        <label for="password">Password</label>
        <input type="password" id="password" name="password"
               minlength="8" autocomplete="new-password" required>

       <button type="submit">
    <%= "ADMIN".equals(selectedRole)
        ? "Create Admin Account"
        : "Create Student Account" %>
</button>
    </form>

    <div class="links">
        Already have an account?
        <a href="login.jsp">Login here</a>
        <br>
        <a href="index.html">Back to Home</a>
    </div>
</div>

<footer>Online Event Registration System</footer>

</body>
</html>