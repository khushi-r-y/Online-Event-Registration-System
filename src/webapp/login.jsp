
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
    <title>Choose Login | Campus Events</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #FFF8EF;
            color: #342E27;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Navigation - matches homepage */
        .navbar {
            background-color: #78815A;
            border-bottom: 1px solid #78815A;
            padding: 0 5%;
            min-height: 72px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
        }

        .brand {
            color: #FFFFFF;
            font-size: 21px;
            font-weight: bold;
            text-decoration: none;
        }

        .home-link {
            color: #FFFFFF;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: color 0.2s ease;
        }

        .home-link:hover {
            color: #F4EBDD;
        }

        main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 50px 20px;
        }

        .login-container {
            width: 100%;
            max-width: 850px;
            text-align: center;
        }

        .section-label {
            display: inline-block;
            background: #E9EBD9;
            color: #59613F;
            padding: 6px 13px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            letter-spacing: 0.7px;
            margin-bottom: 15px;
        }

        h1 {
            font-size: 32px;
            margin-bottom: 10px;
            color: #342E27;
        }

        .subtitle {
            color: #6E6256;
            margin-bottom: 35px;
            font-size: 15px;
        }

        .login-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 24px;
            text-align: left;
        }

        .login-card {
            background: #FFFFFF;
            border: 1px solid #E8DCCB;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 18px rgba(52, 46, 39, 0.05);
            display: flex;
            flex-direction: column;
        }

        .card-icon {
            width: 46px;
            height: 46px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #E9EBD9;
            color: #59613F;
            border-radius: 9px;
            font-size: 23px;
            margin-bottom: 18px;
        }

        .login-card h2 {
            color: #8E482D;
            font-size: 22px;
            margin-bottom: 12px;
        }

        .login-card p {
            color: #6E6256;
            font-size: 14px;
            line-height: 1.7;
            flex: 1;
            margin-bottom: 24px;
        }

        /* Orange login buttons */
        .login-button {
            display: block;
            width: 100%;
            text-align: center;
            padding: 12px 15px;
            border: none;
            border-radius: 6px;
            background: #C7653B;
            color: #FFFFFF;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            transition: background-color 0.2s ease;
        }

        .login-button:hover {
            background: #8E482D;
        }

        .register-note {
            margin-top: 28px;
            font-size: 14px;
            color: #6E6256;
        }

        .register-note a {
            display: inline-block;
            color: #FFFFFF;
            background: #C7653B;
            padding: 9px 14px;
            border-radius: 5px;
            margin-left: 5px;
            font-weight: bold;
            text-decoration: none;
            transition: background-color 0.2s ease;
        }

        .register-note a:hover {
            background: #8E482D;
        }

        footer {
            background: #342E27;
            color: #FFF8EF;
            text-align: center;
            padding: 17px;
            font-size: 13px;
        }

        @media (max-width: 600px) {
            .navbar {
                padding: 0 5%;
                min-height: 68px;
            }

            .login-grid {
                grid-template-columns: 1fr;
            }

            h1 {
                font-size: 27px;
            }

            .login-card {
                padding: 25px;
            }

            main {
                padding: 35px 16px;
            }

            .register-note a {
                margin-top: 10px;
            }
        }
    </style>
</head>

<body>

    <!-- Navigation -->
    <header class="navbar">
        <a href="<%= context %>/index.html" class="brand">
            Campus Events
        </a>

        <a href="<%= context %>/index.html" class="home-link">
            Home
        </a>
    </header>

    <main>
        <div class="login-container">

            <span class="section-label">CAMPUS EVENTS PORTAL</span>

            <h1>Welcome Back!</h1>

            <p class="subtitle">
                Choose your login portal to continue.
            </p>

            <div class="login-grid">

                <!-- Student login -->
                <div class="login-card">

                    <div class="card-icon">&#127891;</div>

                    <h2>Student Login</h2>

                    <p>
                        Explore college events, register for workshops,
                        and manage your event registrations.
                    </p>

                    <a href="<%= context %>/student-login.jsp"
                       class="login-button">
                        Login as Student
                    </a>

                </div>

                <!-- Admin login -->
                <div class="login-card">

                    <div class="card-icon">&#128274;</div>

                    <h2>Admin Login</h2>

                    <p>
                        Access the administration portal to add events,
                        update event details, and manage listings.
                    </p>

                    <a href="<%= context %>/admin-login.jsp"
                       class="login-button">
                        Login as Admin
                    </a>

                </div>

            </div>

<p class="signup-text">
    Don't have an account?
    <a href="<%= context %>/create-account.jsp">Create an account</a>
</p>
           
        </div>
    </main>

    <footer>
        Online Event Registration System
    </footer>

</body>
</html>
