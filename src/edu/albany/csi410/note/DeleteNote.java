package edu.albany.csi410.note;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.albany.csi410.session.LoginEnum;

/**
 * Servlet implementation class DeleteNote
 */
@WebServlet("/DeleteNote")
public class DeleteNote extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteNote() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        int noteID = Integer.parseInt(request.getParameter("NOTE_ID"));
        
		try {
		      
            //Load the Connector/J
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Open a connection
            Connection DB_Connnection = DriverManager.getConnection(LoginEnum.hostname.getValue(), LoginEnum.username.getValue(), LoginEnum.password.getValue());

            // Execute SQL query
            Statement DELETE_NOTE_SQL_Statement = DB_Connnection.createStatement();
            String DELETE_NOTE_SQL_Query = "DELETE FROM NOTES WHERE NOTE_ID="+noteID+";";
            DELETE_NOTE_SQL_Statement.executeUpdate(DELETE_NOTE_SQL_Query);
            
            // Clean-up environment
            DELETE_NOTE_SQL_Statement.close();
            DB_Connnection.close();

            HttpSession session = request.getSession(false);
            session.setAttribute("result", "delete_success");
            
        	response.sendRedirect("user/home.jsp");
		
		} catch (Exception e) {
            
        	//System.out.println(e);
            HttpSession session = request.getSession(false);
            session.setAttribute("result", "delete_error");
            
        	response.sendRedirect("user/home.jsp");
        }
	}
}
