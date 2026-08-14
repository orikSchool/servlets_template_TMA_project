<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>סיכום ציונים וממוצעים</title>
    <style>
        body { font-family: sans-serif; direction: rtl; margin: 20px; }
        .topbar { margin-bottom: 20px; padding-bottom: 10px; border-bottom: 1px solid #ccc; }
        table, th, td { border: 1px solid #ccc; border-collapse: collapse; padding: 10px; text-align: center; }
        table { width: 100%; margin-top: 15px; }
        .actions { margin-top: 20px; }
        .btn { padding: 8px 16px; background: #9D9D9D; color: white; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>

    <div class="topbar">
        <span>שלום, <b><%= session.getAttribute("username") %></b></span> |
        <a href="${pageContext.request.contextPath}/logout">התנתק</a>
    </div>

    <div class="content">
        <h2>סיכום ציונים וממוצעים כלליים</h2>

        <table>
            <thead>
                <tr>
                    <th>קטגוריה</th>
                    <th>הציון האישי שלך</th>
                    <th>ממוצע כל המשתמשים</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>ציון סופי כיתה י'א</td>
                    <td><b>${g11_final != null ? g11_final : "-"}</b></td>
                    <td><b>${avg_g11}</b></td>
                </tr>
                <tr>
                    <td>ציון סופי כיתה י'ב</td>
                    <td><b>${g12_final != null ? g12_final : "-"}</b></td>
                    <td><b>${avg_g12}</b></td>
                </tr>
                <tr style="background: #868686;">
                    <td><b>ציון סופי כולל</b></td>
                    <td><b style="color: #868686;">${total_final != null ? total_final : "-"}</b></td>
                    <td><b>${avg_total}</b></td>
                </tr>
            </tbody>
        </table>

        <div class="actions">
            <a href="${pageContext.request.contextPath}/home" class="btn">עדכן ציונים</a>
        </div>
    </div>

</body>
</html>