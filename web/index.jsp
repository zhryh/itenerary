<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1 class="text-center">Welcome to Travel Planner</h1>
    <h3 class="text-center">Plan, Manage, and Enjoy Your Journey</h3>
    <div class="container mt-5">
        <h2>Login</h2>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger">Username atau Password salah!</div>
        <% } %>
        <form action="LoginServlet" method="post">
            <div class="mb-3">
                <label>Username:</label>
                <input type="text" name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Password:</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>

        <!-- Registrasi Link -->
        <div class="mt-3">
            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        </div>
    </div>
</body>
</html>
