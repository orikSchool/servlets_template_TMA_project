<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>התחברות והרשמה - מחשבון ציונים</title>
    <!-- Google Fonts - Heebo for clean Hebrew typography -->
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --secondary: #64748b;
            --secondary-hover: #475569;
            --bg-color: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
            --error-bg: #fef2f2;
            --error-text: #dc2626;
            --error-border: #fecaca;
            --shadow-md: 0 4px 6px -1px rgba(0,0,0,0.05), 0 2px 4px -1px rgba(0,0,0,0.03);
            --radius: 12px;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Heebo', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            direction: rtl;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
        }

        .login-box {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            padding: 2.5rem 2rem;
            width: 100%;
            max-width: 400px;
            box-shadow: var(--shadow-md);
        }

        .login-box h1 {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 1.5rem;
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1.25rem;
        }

        .input-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        label {
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--text-muted);
        }

        input[type=text], input[type=password] {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-family: 'Heebo', sans-serif;
            font-size: 1rem;
            color: var(--text-main);
            background-color: #fff;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input[type=text]:focus, input[type=password]:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
        }

        .btn-container {
            display: flex;
            gap: 0.75rem;
            margin-top: 0.5rem;
        }

        button {
            flex: 1;
            padding: 0.8rem;
            border: none;
            border-radius: 8px;
            font-family: 'Heebo', sans-serif;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s, transform 0.1s;
        }

        button:active {
            transform: scale(0.98);
        }

        .btn-login {
            background-color: var(--primary);
            color: white;
            box-shadow: 0 1px 3px rgba(79, 70, 229, 0.3);
        }

        .btn-login:hover {
            background-color: var(--primary-hover);
        }

        .btn-register {
            background-color: #f1f5f9;
            color: var(--text-main);
            border: 1px solid var(--border-color);
        }

        .btn-register:hover {
            background-color: #e2e8f0;
        }

        .error {
            background-color: var(--error-bg);
            color: var(--error-text);
            border: 1px solid var(--error-border);
            padding: 0.75rem 1rem;
            border-radius: 8px;
            font-size: 0.9rem;
            text-align: center;
            margin-top: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h1>כניסה למערכת</h1>
        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="input-group">
                <label for="username">שם משתמש</label>
                <input type="text" id="username" name="username" required autofocus/>
            </div>

            <div class="input-group">
                <label for="password">סיסמה</label>
                <input type="password" id="password" name="password" required/>
            </div>

            <div class="btn-container">
                <button type="submit" name="action" value="login" class="btn-login">התחבר</button>
                <button type="submit" name="action" value="register" class="btn-register">הרשם</button>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>
        </form>
    </div>
</body>
</html>