<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TravelPlanner</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar-brand {
            color: #007bff;
            font-weight: bold;
        }
        .section {
            padding: 50px 0;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="#">TravelPlanner</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#itineraries">Itineraries</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#budgets">Budgets</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#recommendations">Recommendations</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="bg-primary text-white text-center py-5">
        <div class="container">
            <h1>Welcome to TravelPlanner</h1>
            <p>Plan, Manage, and Enjoy Your Journey</p>
        </div>
    </header>

    <section id="itineraries" class="section">
        <div class="container text-center">
            <h2>Manage Your Itineraries</h2>
            <p>Keep track of your travel plans with ease.</p>
            <a href="itinerary.jsp" class="btn btn-primary">View Itineraries</a>
        </div>
    </section>

    <section id="budgets" class="section bg-light">
        <div class="container text-center">
            <h2>Track Your Budget</h2>
            <p>Stay on top of your travel expenses.</p>
            <a href="viewBudget.jsp" class="btn btn-secondary">Manage Budget</a>
        </div>
    </section>

    <section id="recommendations" class="section">
        <div class="container text-center">
            <h2>Get Travel Recommendations</h2>
            <p>Discover the best places and restaurants for your trip.</p>
            <a href="recommendations.jsp" class="btn btn-success">Explore Recommendations</a>
        </div>
    </section>

    <footer class="bg-dark text-white text-center py-4">
        <div class="container">
            <p>&copy; 2025 TravelPlanner. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
