<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>התחברות והרשמה</title>
    <style>
        body { font-family: sans-serif; direction: rtl; margin: 40px; }
        .login-box { max-width: 300px; }
        div { margin-bottom: 10px; }
        label { display: block; margin-bottom: 3px; }
        input[type=text], input[type=password] { width: 100%; padding: 5px; box-sizing: border-box; }
        button { padding: 5px 15px; cursor: pointer; }
        .error { color: red; margin-top: 10px; }
    </style>
</head>
<body>
    <div class="login-box">
        <h1>כניסה למערכת</h1>
        <form method="post" action="${pageContext.request.contextPath}/login">
            <label for="username">שם משתמש</label>
            <input type="text" id="username" name="username" required autofocus/>

            <label for="password">סיסמה</label>
            <input type="password" id="password" name="password" required/>

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