
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.busbooking.utils.DBConnection;

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String uid = request.getParameter("uid");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String gen = request.getParameter("gen");
        String email = request.getParameter("email");
        String phno = request.getParameter("phno");
        String addrs = request.getParameter("addrs");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "UPDATE userdetails SET fname=?, lname=?, gen=?, email=?, phno=?, addrs=? WHERE uid=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, fname);
            ps.setString(2, lname);
            ps.setString(3, gen);
            ps.setString(4, email);
            ps.setString(5, phno);
            ps.setString(6, addrs);
            ps.setString(7, uid);

            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<script type='text/javascript'>");
                out.println("alert('User profile updated successfully!');");
                out.println("window.location.href = 'EditUserProfile.jsp';"); // No UID -> clears form
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('Failed to update user profile.');");
                out.println("location='EditUserProfile.jsp?uid=" + uid + "';");
                out.println("</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script type='text/javascript'>");
            out.println("alert('Error occurred: " + e.getMessage() + "');");
            out.println("location='EditUserProfile.jsp?uid=" + uid + "';");
            out.println("</script>");
        }
    }
}
