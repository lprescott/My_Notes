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
 * Servlet implementation class EditNote
 */
@WebServlet("/EditNote")
public class EditNote extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditNote() {
        super();
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
		int noteID = Integer.parseInt(request.getParameter("NOTE_ID"));
        int userID = Integer.parseInt(request.getParameter("USER_ID"));
		String title = request.getParameter("note-title");
        String text = request.getParameter(noteID + "_textarea");

		try {
            //Load the Connector/J
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Open a connection
            Connection DB_Connnection = DriverManager.getConnection(LoginEnum.hostname.getValue(), LoginEnum.username.getValue(), LoginEnum.password.getValue());
            
            //Insert into DB
            Statement EDIT_NOTE_Statement = DB_Connnection.createStatement();
            String EDIT_NOTE_SQL_Query = "UPDATE NOTES SET TITLE = '" + title + "', TEXT = '" + text + "' WHERE USER_ID = " + userID + " AND NOTE_ID = " + noteID + ";";
            EDIT_NOTE_Statement.executeUpdate(EDIT_NOTE_SQL_Query);

            // Clean-up environment
            EDIT_NOTE_Statement.close();
            DB_Connnection.close();
            
            HttpSession session = request.getSession(false);
            session.setAttribute("result", "edit_success");
            
            response.sendRedirect("user/home.jsp");
    
        }catch(Exception e) {
        	
        	System.out.println(e);
            HttpSession session = request.getSession(false);
            session.setAttribute("result", "edit_error");
            
        	response.sendRedirect("user/home.jsp");
        }
	}
}
