
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
    String context = request.getContextPath();

   
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Login | Online Event Registration</title>

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
    padding: 18px 7%;
    color: white;
}

nav a {
    color: white;
    text-decoration: none;
    font-weight: bold;
}

main {
    min-height: 85vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 35px 18px;
}

.login-card {
    width: 100%;
    max-width: 430px;
    padding: 36px;
    background: white;
    border: 1px solid #E8DCCB;
    border-radius: 14px;
    box-shadow: 0 8px 25px rgba(52, 46, 39, 0.06);
}

.eyebrow {
    color: #C7653B;
    font-size: 13px;
    font-weight: bold;
    text-transform: uppercase;
    letter-spacing: 1px;
}

h1 {
    margin: 10px 0;
    font-size: 29px;
}

.description {
    color: #6E6256;
    line-height: 1.6;
    margin-bottom: 25px;
}

label {
    display: block;
    font-weight: bold;
    font-size: 14px;
    margin: 17px 0 8px;
}

input {
    width: 100%;
    padding: 12px;
    border: 1px solid #D8CCBD;
    border-radius: 7px;
    font-size: 15px;
}

input:focus {
    outline: 2px solid #C7653B;
    border-color: transparent;
}

button {
    width: 100%;
    margin-top: 24px;
    padding: 13px;
    border: none;
    border-radius: 7px;
    background: #C7653B;
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

button:hover {
    background: #8E482D;
}

.message {
    padding: 11px;
    border-radius: 6px;
    background: #FCE9E2;
    color: #8E482D;
    font-size: 14px;
    margin: 15px 0;
}

.links {
    text-align: center;
    margin-top: 22px;
    font-size: 14px;
    line-height: 2;
}

.links a {
    color: #78815A;
    font-weight: bold;
    text-decoration: none;
}

@media (max-width: 480px) {
    .login-card { padding: 25px 20px; }
}
</style>
</head>

<body>
<nav>
    <a href="<%= context %>/index.html">Online Event Registration</a>
</nav>

<main>
    <section class="login-card">
        <div class="eyebrow">Student Portal</div>
        <h1>Login as a Student</h1>
        <p class="description">
            Sign in to explore college events, register for workshops,
            and manage your registrations.
        </p>

        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="message">
                Invalid student email or password. Please try again.
            </div>
        <% } %>

        <% if ("1".equals(request.getParameter("registered"))) { %>
            <div class="message">
                Account created successfully. Please log in.
            </div>
        <% } %>

        <form action="<%= context %>/login" method="post">
            <input type="hidden" name="loginType" value="STUDENT">

            <label for="email">Student Email</label>
            <input type="email" id="email" name="email"
                   autocomplete="username" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password"
                   autocomplete="current-password" required>

            <button type="submit">Student Login</button>
        </form>

        <div class="links">
            New student? <a href="<%= context %>/register.jsp">Create an account</a>
            <br>
            Are you an administrator?
            <a href="<%= context %>/admin-login.jsp">Admin Login</a>
            <br>
            <a href="<%= context %>/index.html">Back to Home</a>
        </div>
    </section>
</main>
</body>
</html>
