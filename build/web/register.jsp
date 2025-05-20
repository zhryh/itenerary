<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1 class="text-center">Register a New Account</h1>
    <div class="container mt-5">
        <form action="RegisterServlet" method="post">
            <div class="mb-3">
                <label for="username">Username:</label>
                <input type="text" name="username" id="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="password">Password:</label>
                <input type="password" name="password" id="password" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="email">Email:</label>
                <input type="email" name="email" id="email" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Register</button>
        </form>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger mt-3">Something went wrong, please try again!</div>
        <% } %>
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success mt-3">Registration successful, you can now log in!</div>
        <% } %>
    </div>
</body>
</html>
