<%@page import="model.Itinerary"%>
<%@page import="model.ItineraryItem"%>
<%@page import="dao.ItineraryItemDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Manage Itineraries</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container my-5">
        <!-- Navigation Buttons -->
        <div class="mb-4">
            <a href="#view-itineraries" class="btn btn-success">View All Itineraries</a>
            <a href="#add-itinerary" class="btn btn-primary">Add New Itinerary</a>
            <a href="#edit-itinerary" class="btn btn-warning">Edit Itinerary</a>
            <a href="#delete-itinerary" class="btn btn-danger">Delete Itinerary</a>
        </div>

        <!-- View Itineraries Section -->
        <div id="view-itineraries">
            <div class="card shadow mb-5">
                <div class="card-header bg-success text-white text-center">
                    <h2>All Itineraries</h2>
                </div>
                <div class="card-body">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Items</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                List<Itinerary> itineraries = (List<Itinerary>) request.getAttribute("itineraries");
                                if (itineraries != null && !itineraries.isEmpty()) {
                                    int index = 1;
                                    for (Itinerary itinerary : itineraries) {
                                        ItineraryItemDAO itemDAO = new ItineraryItemDAO();
                                        List<ItineraryItem> items = itemDAO.getItemsByItineraryId(itinerary.getItineraryId());
                            %>
                            <tr>
                                <td><%= index++ %></td>
                                <td><%= itinerary.getTitle() %></td>
                                <td><%= itinerary.getStartDate() %></td>
                                <td><%= itinerary.getEndDate() %></td>
                                <td>
                                    <% if (items != null && !items.isEmpty()) { %>
                                        <ul>
                                            <% for (ItineraryItem item : items) { %>
                                                <li><%= item.getDescription() %> - <%= item.getDate() %> at <%= item.getTime() %></li>
                                            <% } %>
                                        </ul>
                                    <% } else { %>
                                        <span>No items</span>
                                    <% } %>
                                </td>
                                <td>
                                    <a href="itinerary?action=editForm&itineraryId=<%= itinerary.getItineraryId() %>" 
                                       class="btn btn-warning btn-sm">Edit</a>
                                    <a href="itinerary?action=delete&itineraryId=<%= itinerary.getItineraryId() %>" 
                                       class="btn btn-danger btn-sm" 
                                       onclick="return confirm('Are you sure you want to delete this itinerary?');">
                                       Delete
                                    </a>
                                </td>
                            </tr>
                            <% 
                                    }
                                } else { 
                            %>
                            <tr>
                                <td colspan="6" class="text-center">No itineraries found.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Add Itinerary Section -->
        <div id="add-itinerary">
            <div class="card shadow mb-5">
                <div class="card-header bg-primary text-white text-center">
                    <h2>Add Itinerary</h2>
                </div>
                <div class="card-body">
                    <form method="POST" action="itinerary">
                        <input type="hidden" name="action" value="add">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="title" name="title" placeholder="Title" required>
                            <label for="title">Title</label>
                        </div>
                        <div class="form-group mb-3">
                            <label for="startDate">Start Date</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" required>
                        </div>
                        <div class="form-group mb-3">
                            <label for="endDate">End Date</label>
                            <input type="date" class="form-control" id="endDate" name="endDate" required>
                        </div>
                        <div id="items-container">
                            <h5>Itinerary Items</h5>
                            <div class="item-entry border p-3 mb-3">
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" name="itemDescriptions[]" placeholder="Description" required>
                                    <label>Description</label>
                                </div>
                                <div class="form-group mb-3">
                                    <label>Date</label>
                                    <input type="date" class="form-control" name="itemDates[]" required>
                                </div>
                                <div class="form-group mb-3">
                                    <label>Time</label>
                                    <input type="time" class="form-control" name="itemTimes[]" required>
                                </div>
                            </div>
                        </div>
                        <button type="button" class="btn btn-outline-secondary" id="addItemButton">Add Item</button>
                        <div class="text-center mt-4">
                            <button type="submit" class="btn btn-primary w-100">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

<%--        <!-- Edit Itinerary Section -->
        <div id="edit-itinerary">
            <div class="card shadow mb-5">
                <div class="card-header bg-warning text-dark text-center">
                    <h2>Edit Itinerary</h2>
                </div>
                <div class="card-body">
                    <form method="POST" action="itinerary">
                        <input type="hidden" name="action" value="edit">
                        <div class="form-group mb-3">
                            <label for="itineraryId">Select Itinerary to Edit</label>
                            <select class="form-select" id="itineraryId" name="itineraryId" required>
                                <% 
                                    if (itineraries != null && !itineraries.isEmpty()) {
                                        for (Itinerary itinerary : itineraries) {
                                %>
                                <option value="<%= itinerary.getItineraryId() %>"><%= itinerary.getTitle() %></option>
                                <% 
                                        }
                                    } else { 
                                %>
                                <option disabled>No itineraries available</option>
                                <% } %>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Load Itinerary</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Delete Itinerary Section -->
        <div id="delete-itinerary">
            <div class="card shadow mb-5">
                <div class="card-header bg-danger text-white text-center">
                    <h2>Delete Itinerary</h2>
                </div>
                <div class="card-body">
                    <form method="POST" action="itinerary">
                        <input type="hidden" name="action" value="delete">
                        <div class="form-group mb-3">
                            <label for="itineraryId">Select Itinerary to Delete</label>
                            <select class="form-select" id="itineraryId" name="itineraryId" required>
                                <% 
                                    if (itineraries != null && !itineraries.isEmpty()) {
                                        for (Itinerary itinerary : itineraries) {
                                %>
                                <option value="<%= itinerary.getItineraryId() %>"><%= itinerary.getTitle() %></option>
                                <% 
                                        }
                                    } else { 
                                %>
                                <option disabled>No itineraries available</option>
                                <% } %>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-danger w-100">Delete</button>
                    </form>
                </div>
            </div>
        </div>
    </div>--%>

    <script>
        document.getElementById('addItemButton').addEventListener('click', function () {
            const container = document.getElementById('items-container');
            const entry = document.createElement('div');
            entry.classList.add('item-entry', 'border', 'p-3', 'mb-3');
            entry.innerHTML = `
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" name="itemDescriptions[]" placeholder="Description" required>
                    <label>Description</label>
                </div>
                <div class="form-group mb-3">
                    <label>Date</label>
                    <input type="date" class="form-control" name="itemDates[]" required>
                </div>
                <div class="form-group mb-3">
                    <label>Time</label>
                    <input type="time" class="form-control" name="itemTimes[]" required>
                </div>
            `;
            container.appendChild(entry);
        });
    </script>
</body>
</html>
