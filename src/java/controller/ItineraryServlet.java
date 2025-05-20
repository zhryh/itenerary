/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ItineraryDAO;
import dao.ItineraryItemDAO;
import model.Itinerary;
import model.ItineraryItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/itinerary")
public class ItineraryServlet extends HttpServlet {
    private final ItineraryDAO itineraryDAO = new ItineraryDAO();
    private final ItineraryItemDAO itemDAO = new ItineraryItemDAO();

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    try {
        if ("view".equals(action)) {
            List<Itinerary> itineraries = itineraryDAO.getAllItineraries();
            request.setAttribute("itineraries", itineraries);
            request.getRequestDispatcher("itinerary.jsp").forward(request, response);
        } else if ("editForm".equals(action)) {
            int itineraryId = Integer.parseInt(request.getParameter("itineraryId"));
            Itinerary itinerary = itineraryDAO.getItineraryById(itineraryId);
            List<ItineraryItem> items = itemDAO.getItemsByItineraryId(itineraryId);

            request.setAttribute("itinerary", itinerary);
            request.setAttribute("items", items);
            request.getRequestDispatcher("editItinerary.jsp").forward(request, response);
        } else if ("delete".equals(action)) { // Logika penghapusan
            int itineraryId = Integer.parseInt(request.getParameter("itineraryId"));
            itemDAO.deleteItemsByItineraryId(itineraryId); // Hapus semua item terkait
            itineraryDAO.deleteItinerary(itineraryId);     // Hapus itinerary
            response.sendRedirect("itinerary?action=view"); // Kembali ke halaman utama
        }
    } catch (SQLException e) {
        throw new ServletException("Error accessing database", e);
    }
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                // Existing logic for adding itinerary
                Itinerary itinerary = new Itinerary();
                itinerary.setTitle(request.getParameter("title"));
                itinerary.setStartDate(java.sql.Date.valueOf(request.getParameter("startDate")));
                itinerary.setEndDate(java.sql.Date.valueOf(request.getParameter("endDate")));
                int itineraryId = itineraryDAO.addItinerary(itinerary);

                String[] descriptions = request.getParameterValues("itemDescriptions[]");
                String[] dates = request.getParameterValues("itemDates[]");
                String[] times = request.getParameterValues("itemTimes[]");

                if (descriptions != null) {
                    for (int i = 0; i < descriptions.length; i++) {
                        ItineraryItem item = new ItineraryItem();
                        item.setItineraryId(itineraryId);
                        item.setDescription(descriptions[i]);
                        item.setDate(java.sql.Date.valueOf(dates[i]));
                        item.setTime(times[i]);
                        itemDAO.addItem(item);
                    }
                }

                response.sendRedirect("itinerary?action=view");
            } else if ("edit".equals(action)) {
                int itineraryId = Integer.parseInt(request.getParameter("itineraryId"));
                Itinerary itinerary = new Itinerary();
                itinerary.setItineraryId(itineraryId);
                itinerary.setTitle(request.getParameter("title"));
                itinerary.setStartDate(java.sql.Date.valueOf(request.getParameter("startDate")));
                itinerary.setEndDate(java.sql.Date.valueOf(request.getParameter("endDate")));

                itineraryDAO.updateItinerary(itinerary);

                String[] descriptions = request.getParameterValues("itemDescriptions[]");
                String[] dates = request.getParameterValues("itemDates[]");
                String[] times = request.getParameterValues("itemTimes[]");

                itemDAO.deleteItemsByItineraryId(itineraryId); // Clear existing items
                if (descriptions != null) {
                    for (int i = 0; i < descriptions.length; i++) {
                        ItineraryItem item = new ItineraryItem();
                        item.setItineraryId(itineraryId);
                        item.setDescription(descriptions[i]);
                        item.setDate(java.sql.Date.valueOf(dates[i]));
                        item.setTime(times[i]);
                        itemDAO.addItem(item);
                    }
                }

                response.sendRedirect("itinerary?action=view");
            } else if ("delete".equals(action)) {
                int itineraryId = Integer.parseInt(request.getParameter("itineraryId"));
                itemDAO.deleteItemsByItineraryId(itineraryId);
                itineraryDAO.deleteItinerary(itineraryId);
                response.sendRedirect("itinerary?action=view");
            }
        } catch (SQLException e) {
            throw new ServletException("Error processing request", e);
        }
    }
}
