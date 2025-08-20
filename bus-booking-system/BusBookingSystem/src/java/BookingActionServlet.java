import com.busbooking.utils.DBConnection;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(urlPatterns = {"/BookingActionServlet"})
public class BookingActionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bid = request.getParameter("bid"); // updated to get booking id
        String action = request.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {
            String newStatus = "pending";
            if ("approve".equals(action)) {
                newStatus = "approved";
            } else if ("decline".equals(action)) {
                newStatus = "declined";
            }

            String sql = "UPDATE ticketbooking SET status=? WHERE bid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setString(2, bid);
            int rowsUpdated = ps.executeUpdate();

            response.sendRedirect("ConfirmTicketBooking.jsp?msg=" + (rowsUpdated > 0 ? "success" : "fail"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ConfirmTicketBooking.jsp?msg=error");
        }
    }
}
