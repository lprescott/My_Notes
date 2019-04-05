package edu.albany.csi410.session;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

/**
 * Servlet implementation class LoginServlet
 * 
 * This servlet connects to our QUIZ MySQL database, checking if the posted login information corresponds to known user/admin
 * logins and/or returns/redirects the the relevant information/page.
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = 0;

    	String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
        	
        	Logout.invalidateOldSession(request);

            //Load the Connector/J
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Open a connection
            Connection DB_Connnection = DriverManager.getConnection(LoginEnum.hostname.getValue(), LoginEnum.username.getValue(), LoginEnum.password.getValue());
            
            // Execute SQL queries
            Statement USER_SQL_Statement = DB_Connnection.createStatement();
            String USER_SQL_Query = "SELECT USER_ID, USERNAME, PASSWORD FROM USERS";
            
            ResultSet USER_Results = USER_SQL_Statement.executeQuery(USER_SQL_Query);


            // Extract data from result set: USER_Results
            while (USER_Results.next()) {
                if (username.equals(USER_Results.getString("USERNAME")) && password.equals(USER_Results.getString("PASSWORD"))) {
                	
                	//generate a new session
                    //create jssessionid cookie
                    HttpSession session = request.getSession(true);

                    //Expiration in 10 minutes
                    session.setMaxInactiveInterval(10 * 60);
                    
                    //Add session attributes
    				session.setAttribute("id", id);
    				session.setAttribute("username", username);
    				session.setAttribute("login", "true");
                    
                    // Clean-up environment
                    USER_Results.close();
                    USER_SQL_Statement.close();
                    DB_Connnection.close();
                    
                    //redirect to user main page
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                    return;
                }
            }

        	//generate a new session
            //create jssessionid cookie
            HttpSession session = request.getSession(true);

            //Expiration in 10 minutes
            session.setMaxInactiveInterval(60);
            
            //Add session attributes
			session.setAttribute("id", null);
			session.setAttribute("login", "false");
			session.setAttribute("username", username);
            
            // Clean-up environment
            USER_Results.close();
            USER_SQL_Statement.close();
            DB_Connnection.close();
            
            //redirect to user main page
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;

        } catch (Exception e) {
            //System.out.println(e);
        	      
        }
    }
}