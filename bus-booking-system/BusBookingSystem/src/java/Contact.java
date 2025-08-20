import com.busbooking.utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.Statement;

@WebServlet(urlPatterns = {"/Contact"})
public class Contact extends HttpServlet {

    // Get UID from username stored in session
    public static String getUID(String uname) {
        String uid = null;
        try {
            if (uname != null) {
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(
                    "SELECT uid FROM userdetails WHERE uname = ?"
                );
                stmt.setString(1, uname);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    uid = rs.getString("uid");
                }

                conn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return uid;
    }

    // Check if a pending contact message already exists
    public static int pendingCheck(String uid) {
        int check = 0;
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM contactus WHERE uid = ? AND status = ?"
            );
            stmt.setString(1, uid);
            stmt.setString(2, "pending");
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                check = 1;
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }
    
    public static String getNextTID() {
    String nextTID = "T001"; // default if table is empty

    try {
        Connection conn = DBConnection.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT MAX(trackid) FROM contactus");

        if (rs.next()) {
            String maxTID = rs.getString(1); // Get the current max ID
            if (maxTID != null && maxTID.startsWith("T")) {
                int num = Integer.parseInt(maxTID.substring(1)); // Strip the "T" and parse the number
                num++; // Increment
                nextTID = String.format("T%03d", num); // Format as T001, T002, etc.
            }
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    return nextTID;
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("ContactUs.jsp?error=1"); // User not found
            return;
        }

        String uid = getUID(username);
        if (uid == null) {
            response.sendRedirect("ContactUs.jsp?error=1"); // User ID lookup failed
            return;
        }

        int pend = pendingCheck(uid);
        if (pend != 0) {
            response.sendRedirect("ContactUs.jsp?error=2"); // Already has a pending query
            return;
        }

        String msg = request.getParameter("message");
        if (msg == null || msg.trim().isEmpty()) {
            response.sendRedirect("ContactUs.jsp?error=3"); // Message was empty
            return;
        }

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement insertStmt = conn.prepareStatement(
                "INSERT INTO contactus (trackid,uid, message, status) VALUES (?, ?, ?, ?)"
            );

            insertStmt.setString(1, getNextTID());
            insertStmt.setString(2, uid);
            insertStmt.setString(3, msg);
            insertStmt.setString(4, "pending");

            int i = insertStmt.executeUpdate();

            if (i > 0) {
                out.println("<script type='text/javascript'>");
                out.println("alert('Message sent successfully!');");
                out.println("location='ContactUs.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('Failed. Please try again.');");
                out.println("location='ContactUs.jsp';");
                out.println("</script>");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ContactUs.jsp?error=3"); // Something went wrong
        }
    }
}
