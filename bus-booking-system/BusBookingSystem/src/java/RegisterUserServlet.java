import com.busbooking.utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.ResultSet;

@WebServlet("/RegisterUserServlet")
public class RegisterUserServlet extends HttpServlet {
public static String fetchUname(String uname) {
        
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM user where uname=?");
            ps.setString(1,uname);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getString("uid");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }
        // Validation
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String uid = request.getParameter("uid");
    String uname = request.getParameter("uname");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String gender = request.getParameter("gender");
    String address = request.getParameter("address");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");

    HttpSession session = request.getSession();

    // Check if username already exists
    String existingUID = fetchUname(uname);
    if (existingUID != null) {
        session.setAttribute("error", "Username already exists!");
        response.sendRedirect("NewUser.jsp");
        return;
    }

    // Check if passwords match
    if (!password.equals(confirmPassword)) {
        session.setAttribute("error", "Passwords do not match!");
        response.sendRedirect("NewUser.jsp");
        return;
    }

    try {
        Connection conn = DBConnection.getConnection();

        String sql = "INSERT INTO userdetails (uid, uname, fname, lname, gen, addrs, email, phno, upass) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, uid);
        stmt.setString(2, uname);
        stmt.setString(3, fname);
        stmt.setString(4, lname);
        stmt.setString(5, gender);
        stmt.setString(6, address);
        stmt.setString(7, email);
        stmt.setString(8, phone);
        stmt.setString(9, password); // Should hash in production

        PreparedStatement stmt1 = conn.prepareStatement("INSERT INTO user (uid, uname, upass, status) VALUES (?, ?, ?, ?)");
        stmt1.setString(1, uid);
        stmt1.setString(2, uname);
        stmt1.setString(3, password);
        stmt1.setString(4, "user");

        int rows1 = stmt.executeUpdate();
        int rows2 = stmt1.executeUpdate();

        if (rows1 > 0 && rows2 > 0) {
    session.setAttribute("success", "Registration successful! Please login.");
    response.sendRedirect("login.jsp?msg=reg_success");
} else {
    session.setAttribute("error", "Failed to register. Please try again.");
    response.sendRedirect("login.jsp?msg=reg_failed"); // changed to login.jsp to show error
}

        stmt.close();
        stmt1.close();
        conn.close();

    } catch (Exception e) {
        e.printStackTrace(); // optional
        session.setAttribute("error", "Something went wrong. Please try again.");
        response.sendRedirect("NewUser.jsp");
    }
}
}


        
     
        

        
    

