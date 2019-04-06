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
 * @author Luke Prescott
 */

/**
 * Servlet implementation class CreateNote
 */
@WebServlet("/CreateNote")
public class CreateNote extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateNote() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String title = request.getParameter("note-title");
        String text = request.getParameter("new_note_textarea");
        int id = Integer.parseInt(request.getParameter("USER_ID"));
        
        try {
            //Load the Connector/J
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Open a connection
            Connection DB_Connnection = DriverManager.getConnection(LoginEnum.hostname.getValue(), LoginEnum.username.getValue(), LoginEnum.password.getValue());
            
            //Insert into DB
            Statement ADD_NOTE_Statement = DB_Connnection.createStatement();
            String ADD_NOTE_STRING = "INSERT INTO NOTES (TITLE, TEXT, USER_ID) VALUES ('" + title + "', '" + text + "', " + id + ")";
            ADD_NOTE_Statement.executeUpdate(ADD_NOTE_STRING);

            // Clean-up environment
            ADD_NOTE_Statement.close();
            DB_Connnection.close();
            
            HttpSession session = request.getSession(false);
            session.setAttribute("result", "create_success");
            
            response.sendRedirect("user/home.jsp");
    
        }catch(Exception e) {
        	
        	//System.out.println(e);
            HttpSession session = request.getSession(false);
            session.setAttribute("result", "create_error");
            
        	response.sendRedirect("user/home.jsp");
        }
	}

}
