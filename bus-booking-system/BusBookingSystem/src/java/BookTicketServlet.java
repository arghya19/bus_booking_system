import com.busbooking.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/BookTicketServlet")
public class BookTicketServlet extends HttpServlet {
    public static int pendingCheck(String uid){
        int check = 0;
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM ticketbooking where uid=? AND status=?");
            stmt.setString(1, uid);
            stmt.setString(2, "pending");
            ResultSet rs = stmt.executeQuery();
            if(rs.next()){
                check = 1;
            }
            
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return check;
    }
    // Generate next Booking ID like B001, B002...
    public static String getNextBID() {
        String nextBID = "B001";
        try {
            Connection conn = DBConnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT MAX(bid) FROM ticketbooking");

            if (rs.next()) {
                String maxBID = rs.getString(1);
                if (maxBID != null && maxBID.startsWith("B")) {
                    int num = Integer.parseInt(maxBID.substring(1));
                    num++;
                    nextBID = String.format("B%03d", num);
                }
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return nextBID;
    }

    // Get UID from username (uname) stored in session
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
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String uid = null;
        int pend = 0;
        HttpSession session = request.getSession(false);
        if (session != null) {
            String username = (String) session.getAttribute("username");
            if (username != null) {
                uid = getUID(username);
            } else {
                response.sendRedirect("Book_ticket.jsp?error=1");
            }   
        } else {
            response.sendRedirect("login.jsp");
            return;
        }
        if(uid != null){
            pend = pendingCheck(uid);
        }else{
            response.sendRedirect("Book_ticket.jsp?error=2");
        }
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String time = request.getParameter("time");
        String date = request.getParameter("travelDate");
        
        if(pend != 0){
            response.sendRedirect("Book_ticket.jsp?error=3");
        }else{
            try{
                Connection conn = DBConnection.getConnection();
                String bid = getNextBID().toString();
                
                PreparedStatement insertStmt = conn.prepareStatement(
    "INSERT INTO ticketbooking (bid, uid, `from`, `to`, `date`, `time`, `status`) VALUES (?, ?, ?, ?, ?, ?, ?)");

                insertStmt.setString(1, bid);
                insertStmt.setString(2, uid);
                insertStmt.setString(3, from);
                insertStmt.setString(4, to);
                insertStmt.setString(5, date);
                insertStmt.setString(6, time);
                insertStmt.setString(7, "pending");

                int i = insertStmt.executeUpdate();
                if(i > 0){
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Booking successful! Your booking ID is " + bid + "');");
                    out.println("location='User_dashboard.jsp';");
                    out.println("</script>");
                }else{
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Booking failed. Please try again.');");
                    out.println("location='Book_ticket.jsp';");
                    out.println("</script>");
                }
                conn.close();
            }catch(Exception e){
                e.printStackTrace();
                response.sendRedirect("Book_ticket.jsp?error=4");
            }
        }        
    }
}
