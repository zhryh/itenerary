/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.ItineraryItem;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItineraryItemDAO {
    public List<ItineraryItem> getItemsByItineraryId(int itineraryId) throws SQLException {
    String sql = "SELECT * FROM itinerary_items WHERE itinerary_id = ?";
    try (Connection connection = DatabaseConnection.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

        preparedStatement.setInt(1, itineraryId);
        ResultSet resultSet = preparedStatement.executeQuery();

        List<ItineraryItem> items = new ArrayList<>();
        while (resultSet.next()) {
            ItineraryItem item = new ItineraryItem();
            item.setItineraryItemId(resultSet.getInt("item_id")); // Panggilan ini sebelumnya error
            item.setItineraryId(resultSet.getInt("itinerary_id"));
            item.setDescription(resultSet.getString("description"));
            item.setDate(resultSet.getDate("date"));
            item.setTime(resultSet.getString("time"));
            items.add(item);
        }
        return items;
    }
}


    public void deleteItemsByItineraryId(int itineraryId) throws SQLException {
        String sql = "DELETE FROM itinerary_items WHERE itinerary_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, itineraryId);
            preparedStatement.executeUpdate();
        }
    }

    public void addItem(ItineraryItem item) throws SQLException {
        String sql = "INSERT INTO itinerary_items (itinerary_id, description, date, time) VALUES (?, ?, ?, ?)";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, item.getItineraryId());
            preparedStatement.setString(2, item.getDescription());
            preparedStatement.setDate(3, (Date) item.getDate());
            preparedStatement.setString(4, item.getTime());
            preparedStatement.executeUpdate();
        }
    }
}
