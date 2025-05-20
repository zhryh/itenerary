<%-- 
    Document   : editItinerary
    Created on : Jan 4, 2025, 2:52:53 AM
    Author     : asus
--%>

<%@page import="model.ItineraryItem"%>
<%@page import="model.Itinerary"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Itinerary</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Edit Itinerary</h1>
        <form action="itinerary" method="post" class="mt-4">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="itineraryId" value="${itinerary.itineraryId}">

            <div class="mb-3">
                <label for="title" class="form-label">Title:</label>
                <input type="text" id="title" name="title" class="form-control" value="${itinerary.title}" required>
            </div>

            <div class="mb-3">
                <label for="startDate" class="form-label">Start Date:</label>
                <input type="date" id="startDate" name="startDate" class="form-control" value="${itinerary.startDate}" required>
            </div>

            <div class="mb-3">
                <label for="endDate" class="form-label">End Date:</label>
                <input type="date" id="endDate" name="endDate" class="form-control" value="${itinerary.endDate}" required>
            </div>

            <h3>Items</h3>
            <div id="items-container">
                <c:forEach var="item" items="${items}">
                    <div class="row g-3 align-items-center mb-2">
                        <div class="col-md-4">
                            <label for="itemDescription" class="form-label">Description:</label>
                            <input type="text" name="itemDescriptions[]" class="form-control" value="${item.description}" required>
                        </div>
                        <div class="col-md-3">
                            <label for="itemDate" class="form-label">Date:</label>
                            <input type="date" name="itemDates[]" class="form-control" value="${item.date}" required>
                        </div>
                        <div class="col-md-3">
                            <label for="itemTime" class="form-label">Time:</label>
                            <input type="time" name="itemTimes[]" class="form-control" value="${item.time}" required>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="d-flex justify-content-end mt-4">
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
        </form>
    </div>
</body>
</html>
