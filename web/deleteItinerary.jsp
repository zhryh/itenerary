<%-- 
    Document   : deleteItinerary
    Created on : Jan 4, 2025, 3:18:18 AM
    Author     : asus
--%>

<%@page import="model.Itinerary"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Itinerary</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Delete Itinerary</h1>
        <p>Are you sure you want to delete the following itinerary?</p>
        <table class="table table-bordered">
            <tr>
                <th>Title</th>
                <td>${itinerary.title}</td>
            </tr>
            <tr>
                <th>Start Date</th>
                <td>${itinerary.startDate}</td>
            </tr>
            <tr>
                <th>End Date</th>
                <td>${itinerary.endDate}</td>
            </tr>
        </table>

        <!-- Confirmation Buttons -->
        <form action="itinerary" method="post">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="itineraryId" value="${itinerary.itineraryId}">
            <button type="submit" class="btn btn-danger">Yes, Delete</button>
            <a href="itinerary?action=view" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>
