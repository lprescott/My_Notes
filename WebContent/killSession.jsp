<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//get old session
	HttpSession oldSession = request.getSession(false);
	
	//invalidate
	if (oldSession != null) {
	    oldSession.invalidate();
	}
	
    //redirect to user main page
    response.sendRedirect(request.getContextPath() + "/login.jsp");
%>
</body>
</html>