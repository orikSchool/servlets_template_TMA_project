<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>סיכום ציונים וממוצעים</title>
    <!-- Google Fonts - Heebo for clean Hebrew typography -->
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --bg-color: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
            --table-header-bg: #f1f5f9;
            --highlight-bg: #e0e7ff;
            --highlight-text: #3730a3;
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.05), 0 1px 2px rgba(0,0,0,0.1);
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
            flex-direction: column;
            align-items: center;
            padding: 2rem 1rem;
        }

        .container {
            width: 100%;
            max-width: 750px;
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
        }

        .topbar span {
            color: var(--text-muted);
        }

        .topbar b {
            color: var(--text-main);
        }

        .topbar a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
        }

        .topbar a:hover {
            color: var(--primary-hover);
            text-decoration: underline;
        }

        /* Content Layout */
        .content {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            padding: 2rem;
            box-shadow: var(--shadow-md);
        }

        .content h2 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--text-main);
        }

        /* Table Styling */
        .table-container {
            overflow-x: auto;
            border-radius: 8px;
            border: 1px solid var(--border-color);
            margin-bottom: 1.5rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
            font-size: 1rem;
        }

        th, td {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            background-color: var(--table-header-bg);
            color: var(--text-main);
            font-weight: 600;
        }

        tr:last-child td {
            border-bottom: none;
        }

        /* Highlight Final Total Row */
        .total-row {
            background-color: var(--highlight-bg);
            font-weight: 600;
            color: var(--highlight-text);
        }

        .total-row td {
            border-top: 2px solid #c7d2fe;
            border-bottom: none;
        }

        /* Actions Button */
        .actions {
            display: flex;
            justify-content: flex-start;
        }

        .btn {
            background-color: var(--primary);
            color: white;
            padding: 0.75rem 1.5rem;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.95rem;
            box-shadow: var(--shadow-sm);
            transition: background-color 0.2s, transform 0.1s;
            display: inline-block;
        }

        .btn:hover {
            background-color: var(--primary-hover);
        }

        .btn:active {
            transform: scale(0.98);
        }
    </style>
</head>
<body>

    <div class="container">
        <!-- Topbar -->
        <div class="topbar">
            <span>שלום, <b><%= session.getAttribute("username") %></b></span>
            <a href="${pageContext.request.contextPath}/logout">התנתק</a>
        </div>

        <!-- Main Content -->
        <div class="content">
            <h2>סיכום ציונים וממוצעים כלליים</h2>

            <div class="table-container">
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
                        <tr class="total-row">
                            <td>ציון סופי כולל</td>
                            <td><b>${total_final != null ? total_final : "-"}</b></td>
                            <td><b>${avg_total}</b></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="actions">
                <a href="${pageContext.request.contextPath}/home" class="btn">עדכן ציונים</a>
            </div>
        </div>
    </div>

</body>
</html>