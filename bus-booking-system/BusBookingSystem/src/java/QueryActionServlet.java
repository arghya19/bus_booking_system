
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.busbooking.utils.DBConnection;

@WebServlet("/QueryActionServlet")
public class QueryActionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String trackid = request.getParameter("trackid");
        String action = request.getParameter("action"); // "approve" or "decline"

        if (trackid == null || action == null) {
            response.sendRedirect("ConfirmQueries.jsp?msg=error");
            return;
        }

        String newStatus = action.equals("approve") ? "approved" : "declined";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE contactus SET status = ? WHERE trackid = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setString(2, trackid);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("ConfirmQueries.jsp?msg=success");
            } else {
                response.sendRedirect("ConfirmQueries.jsp?msg=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ConfirmQueries.jsp?msg=error");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
