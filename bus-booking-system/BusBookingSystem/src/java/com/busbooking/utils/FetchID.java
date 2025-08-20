
package com.busbooking.utils;
import com.busbooking.utils.DBConnection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Arghya
 */
public class FetchID {
    public static String getNextUID() {
        String nextUID="101"; // default if no users exist
        try {
            Connection conn = DBConnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT MAX(uid) FROM user");

            if (rs.next()) {
                String maxUID = rs.getString(1);
                if (maxUID != null) {
                    int next = Integer.parseInt(maxUID) + 1;
                    nextUID = Integer.toString(next);
                }
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return nextUID;
    }
}
