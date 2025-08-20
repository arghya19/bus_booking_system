import com.busbooking.utils.DBConnection;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uid = request.getParameter("uid");
        String uname = request.getParameter("username");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("Forgot_pass.jsp?error=2"); // Passwords do not match
            return;
        }

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM user WHERE uid = ? AND uname = ?"
            );
            ps.setString(1, uid);
            ps.setString(2, uname);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Match found, update password
                PreparedStatement updatePs = conn.prepareStatement(
                    "UPDATE user SET upass = ? WHERE uid = ?"
                );
                updatePs.setString(1, newPassword);
                updatePs.setString(2, uid);
                PreparedStatement updatePs1 = conn.prepareStatement(
                    "UPDATE userdetails SET upass = ? WHERE uid = ?"
                );
                updatePs1.setString(1, newPassword);
                updatePs1.setString(2, uid);
                int updateCount1 = updatePs.executeUpdate();
                int updateCount2 = updatePs1.executeUpdate();
                if (updateCount1 > 0 && updateCount2 > 0) {
                    response.sendRedirect("login.jsp?msg=reset_success");
                } else {
                    response.sendRedirect("Forgot_pass.jsp?error=3"); // Update failed
                }

                updatePs.close();
                updatePs1.close();
            } else {
                // User not found
                response.sendRedirect("Forgot_pass.jsp?error=1");
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Forgot_pass.jsp?error=4"); // General error
        }
    }
}
