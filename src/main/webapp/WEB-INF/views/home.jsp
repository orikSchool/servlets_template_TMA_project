<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>מחשבון ציונים במתמטיקה - הזנת נתונים</title>
    <!-- Google Fonts - Heebo for clean Hebrew typography -->
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --primary-hover: #4f46e5;
            --bg-color: #0f172a;
            --card-bg: #1e293b;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --border-color: #334155;
            --input-bg: #0f172a;
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.2);
            --shadow-md: 0 10px 15px -3px rgba(0, 0, 0, 0.3), 0 4px 6px -2px rgba(0, 0, 0, 0.2);
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
            flex-direction: column;
            align-items: center;
            padding: 2rem 1rem;
        }

        .container {
            width: 100%;
            max-width: 650px;
        }

        /* Topbar Header */
        .topbar {
            background: var(--card-bg);
            padding: 1rem 1.5rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow-sm);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            border: 1px solid var(--border-color);
            font-size: 0.95rem;
            flex-wrap: wrap;
            gap: 10px;
        }

        .topbar span {
            color: var(--text-muted);
        }

        .topbar b {
            color: var(--text-main);
        }

        .topbar-links {
            display: flex;
            gap: 1.25rem;
        }

        .topbar a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
        }

        .topbar a:hover {
            color: #818cf8;
            text-decoration: underline;
        }

        /* Main Content Layout */
        .content h2 {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--text-main);
            text-align: right;
        }

        /* Cards */
        .card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            padding: 1.5rem;
            margin-bottom: 1.25rem;
            box-shadow: var(--shadow-sm);
            transition: box-shadow 0.2s, border-color 0.2s;
        }

        .card:hover {
            box-shadow: var(--shadow-md);
            border-color: #475569;
        }

        .card h3 {
            font-size: 1.15rem;
            font-weight: 600;
            color: #818cf8;
            margin-bottom: 1.25rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Grid System */
        .grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        @media (max-width: 480px) {
            .grid {
                grid-template-columns: 1fr;
            }
        }

        .grid div {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        label {
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--text-muted);
        }

        /* Input styling */
        input[type=number] {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-family: 'Heebo', sans-serif;
            font-size: 1rem;
            color: var(--text-main);
            background-color: var(--input-bg);
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input[type=number]:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
        }

        /* Checkbox styling */
        .checkbox-container {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-top: 0.5rem;
            cursor: pointer;
            font-size: 0.9rem;
            color: var(--text-main);
            user-select: none;
        }

        .checkbox-container input[type=checkbox] {
            width: 18px;
            height: 18px;
            accent-color: var(--primary);
            cursor: pointer;
        }

        /* Submit Button */
        button[type=submit] {
            width: 100%;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: var(--radius);
            padding: 0.85rem;
            font-family: 'Heebo', sans-serif;
            font-size: 1.05rem;
            font-weight: 600;
            cursor: pointer;
            box-shadow: var(--shadow-sm);
            transition: background-color 0.2s, transform 0.1s;
            margin-top: 0.5rem;
        }

        button[type=submit]:hover {
            background-color: var(--primary-hover);
        }

        button[type=submit]:active {
            transform: scale(0.99);
        }
    </style>
</head>
<body>

    <div class="container">
        <!-- Topbar -->
        <div class="topbar">
            <span>שלום, <b><%= session.getAttribute("username") %></b></span>
            <div class="topbar-links">
                <a href="${pageContext.request.contextPath}/results">לצפייה בתוצאות וממוצעים</a>
                <a href="${pageContext.request.contextPath}/logout">התנתק</a>
            </div>
        </div>

        <!-- Main Form -->
        <div class="content">
            <h2>הזנת ציונים במתמטיקה</h2>

            <form method="post" action="${pageContext.request.contextPath}/home">

                <!-- Grade 11 Card -->
                <div class="card">
                    <h3>כיתה י״א (משקל: 65%)</h3>
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
                    <div>
                        <label class="checkbox-container">
                            <input type="checkbox" name="g11_war" value="true" ${g11_war ? 'checked' : ''}>
                            שנת מלחמה (60-40 לציון הגבוה)
                        </label>
                    </div>
                </div>

                <!-- Grade 12 Card -->
                <div class="card">
                    <h3>כיתה י"ב (משקל: 35%)</h3>
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
                    <div>
                        <label class="checkbox-container">
                            <input type="checkbox" name="g12_war" value="true" ${g12_war ? 'checked' : ''}>
                            שנת מלחמה (60-40 לציון הגבוה)
                        </label>
                    </div>
                </div>

                <button type="submit">שמור וחשב ציונים</button>
            </form>
        </div>
    </div>

</body>
</html>