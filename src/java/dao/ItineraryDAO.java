package dao;

import model.Itinerary;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItineraryDAO {
    public List<Itinerary> getAllItineraries() throws SQLException {
        String sql = "SELECT * FROM itineraries";
        try (Connection connection = DatabaseConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {

            List<Itinerary> itineraries = new ArrayList<>();
            while (resultSet.next()) {
                Itinerary itinerary = new Itinerary();
                itinerary.setItineraryId(resultSet.getInt("itinerary_id"));
                itinerary.setTitle(resultSet.getString("title"));
                itinerary.setStartDate(resultSet.getDate("start_date"));
                itinerary.setEndDate(resultSet.getDate("end_date"));
                itineraries.add(itinerary);
            }
            return itineraries;
        }
    }

    public Itinerary getItineraryById(int itineraryId) throws SQLException {
        String sql = "SELECT * FROM itineraries WHERE itinerary_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, itineraryId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                Itinerary itinerary = new Itinerary();
                itinerary.setItineraryId(resultSet.getInt("itinerary_id"));
                itinerary.setTitle(resultSet.getString("title"));
                itinerary.setStartDate(resultSet.getDate("start_date"));
                itinerary.setEndDate(resultSet.getDate("end_date"));
                return itinerary;
            }
            return null;
        }
    }

    public int addItinerary(Itinerary itinerary) throws SQLException {
        String sql = "INSERT INTO itineraries (title, start_date, end_date) VALUES (?, ?, ?)";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setString(1, itinerary.getTitle());
            preparedStatement.setDate(2, (Date) itinerary.getStartDate());
            preparedStatement.setDate(3, (Date) itinerary.getEndDate());
            preparedStatement.executeUpdate();

            ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            }
            return -1;
        }
    }

    public void updateItinerary(Itinerary itinerary) throws SQLException {
        String sql = "UPDATE itineraries SET title = ?, start_date = ?, end_date = ? WHERE itinerary_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, itinerary.getTitle());
            preparedStatement.setDate(2, (Date) itinerary.getStartDate());
            preparedStatement.setDate(3, (Date) itinerary.getEndDate());
            preparedStatement.setInt(4, itinerary.getItineraryId());
            preparedStatement.executeUpdate();
        }
    }

    public void deleteItinerary(int itineraryId) throws SQLException {
        String sql = "DELETE FROM itineraries WHERE itinerary_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, itineraryId);
            preparedStatement.executeUpdate();
        }
    }
}
