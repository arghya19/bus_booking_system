// LoginServlet.java
import com.busbooking.utils.DBConnection;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String uname = request.getParameter("username");
        String pass = request.getParameter("password");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE uname=? AND upass=?");
            ps.setString(1, uname);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String status = rs.getString("status");

                // Create session and set username
                HttpSession session = request.getSession();
                session.setAttribute("username", uname);

                if ("admin".equalsIgnoreCase(status)) {
                    response.sendRedirect("Admin_dashboard.jsp");
                } else {
                    response.sendRedirect("User_dashboard.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?error=1"); // Invalid credentials
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=2"); // DB or server error
        }
    }
}
