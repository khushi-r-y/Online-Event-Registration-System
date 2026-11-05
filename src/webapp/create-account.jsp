
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
    String context = request.getContextPath();

    Object userId = session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    if (userId != null) {
        if ("ADMIN".equalsIgnoreCase(role)) {
            response.sendRedirect(context + "/admin-dashboard.jsp");
        } else {
            response.sendRedirect(context + "/events.jsp");
        }
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Create Account | Campus Events</title>

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    min-height: 100vh;
    font-family: Arial, sans-serif;
    background: #FFF8EF;
    color: #342E27;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 24px;
}

.container {
    width: 100%;
    max-width: 780px;
    text-align: center;
}

.eyebrow {
    color: #C7653B;
    font-weight: bold;
    letter-spacing: 2px;
    font-size: 12px;
    text-transform: uppercase;
}

h1 {
    font-size: 34px;
    margin: 14px 0 10px;
}

.subtitle {
    color: #756A60;
    line-height: 1.7;
    margin: 0 auto 32px;
    max-width: 520px;
}

.options {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 22px;
    text-align: left;
}

.option {
    background: #FFFFFF;
    border: 1px solid #E9DCCE;
    border-radius: 18px;
    padding: 28px;
    box-shadow: 0 8px 24px rgba(52, 46, 39, 0.06);
}

.symbol {
    font-size: 34px;
    margin-bottom: 16px;
}

.option h2 {
    font-size: 22px;
    margin: 0 0 12px;
}

.option p {
    color: #756A60;
    line-height: 1.7;
    min-height: 72px;
}

.button {
    display: block;
    text-align: center;
    text-decoration: none;
    background: #C7653B;
    color: white;
    padding: 13px 16px;
    border-radius: 9px;
    font-weight: bold;
    margin-top: 22px;
}

.button:hover {
    background: #8E482D;
}

.back {
    display: inline-block;
    margin-top: 28px;
    color: #8E482D;
    text-decoration: none;
}

@media (max-width: 600px) {
    .options {
        grid-template-columns: 1fr;
    }

    h1 {
        font-size: 28px;
    }

    .option p {
        min-height: auto;
    }
}
</style>
</head>

<body>
<div class="container">

    <div class="eyebrow">Campus Events</div>

    <h1>Create Your Account</h1>

    <p class="subtitle">
        Choose the account type that matches your role to continue
        to the appropriate page.
    </p>

    <div class="options">

        <div class="option">
            <div class="symbol">&#127891;</div>
            <h2>Student Account</h2>
            <p>
    Create an account for an authorized administrator
    to manage campus events and registrations.
</p>
            <a class="button"
               href="<%= context %>/register.jsp?rol=USER">
                Create Student Account
            </a>
        </div>

        <div class="option">
            <div class="symbol">&#128737;</div>
            <h2>Admin Account</h2>
            <p>
                Already an authorized administrator?
                Sign in to manage events and registrations.
            </p>
            <a class="button"
               href="<%= context %>/register.jsp?role=ADMIN">
                Continue as Admin
            </a>
        </div>

    </div>

    <a class="back" href="<%= context %>/index.html">
        &#8592; Back to Home
    </a>

</div>
</body>
</html>
