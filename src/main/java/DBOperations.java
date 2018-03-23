import java.sql.*;

public class DBOperations {

    public String getMovie() throws ClassNotFoundException, SQLException {
        Class.forName("org.postgresql.Driver");

        final java.lang.String URL = "jdbc:postgresql://54.93.65.5:5432/laura7";
        final java.lang.String USERNAME = "fasttrackit_dev";
        final java.lang.String PASSWORD = "fasttrackit_dev";

        Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);

        PreparedStatement pSt = conn.prepareStatement("SELECT movie FROM movies ORDER BY random() LIMIT 1");
        String movieName = "";

        ResultSet rs = pSt.executeQuery();
        if (rs.next()) {
            movieName = rs.getString("movie");
        }

        pSt.close();
        conn.close();

        return movieName.trim();
    }

}
