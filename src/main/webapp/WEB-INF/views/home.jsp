<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>מחשבון ציונים במתמטיקה - הזנת נתונים</title>
    <style>
        body { font-family: sans-serif; direction: rtl; margin: 20px; }
        .topbar { margin-bottom: 20px; padding-bottom: 10px; border-bottom: 1px solid #ccc; }
        .card { border: 1px solid #ccc; padding: 15px; margin-bottom: 15px; }
        .grid { display: flex; gap: 10px; margin-bottom: 10px; }
        .grid div { flex: 1; }
        input[type=number] { width: 100%; padding: 5px; box-sizing: border-box; }
        button, .btn { padding: 8px 16px; cursor: pointer; text-decoration: none; display: inline-block; }
    </style>
</head>
<body>

    <div class="topbar">
        <span>שלום, <b><%= session.getAttribute("username") %></b></span> |
        <a href="${pageContext.request.contextPath}/results">לצפייה בתוצאות וממוצעים</a> |
        <a href="${pageContext.request.contextPath}/logout">התנתק</a>
    </div>

    <div class="content">
        <h2>הזנת ציונים במתמטיקה</h2>

        <form method="post" action="${pageContext.request.contextPath}/home">

            <!-- כיתה יא -->
            <div class="card">
                <h3>כיתה י'א (משקל: 65%)</h3>
                <div class="grid">
                    <div>
                        <label>ציון בחינה:</label>
                        <input type="number" name="g11_exam" min="0" max="100" value="${g11_exam}">
                    </div>
                    <div>
                        <label>ציון מגן:</label>
                        <input type="number" name="g11_magen" min="0" max="100" value="${g11_magen}">
                    </div>
                </div>
                <div style="margin-top: 10px;">
                    <label>
                        <input type="checkbox" name="g11_war" value="true" ${g11_war ? 'checked' : ''}> שנת מלחמה (60-40 לציון הגבוה)
                    </label>
                </div>
            </div>

            <!-- כיתה יב -->
            <div class="card">
                <h3>כיתה י'ב (משקל: 35%)</h3>
                <div class="grid">
                    <div>
                        <label>ציון בחינה:</label>
                        <input type="number" name="g12_exam" min="0" max="100" value="${g12_exam}">
                    </div>
                    <div>
                        <label>ציון מגן:</label>
                        <input type="number" name="g12_magen" min="0" max="100" value="${g12_magen}">
                    </div>
                </div>
                <div style="margin-top: 10px;">
                    <label>
                        <input type="checkbox" name="g12_war" value="true" ${g12_war ? 'checked' : ''}> שנת מלחמה (60-40 לציון הגבוה)
                    </label>
                </div>
            </div>

            <button type="submit">שמור וחשב ציונים</button>
        </form>
    </div>

</body>
</html>