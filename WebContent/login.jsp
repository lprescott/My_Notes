<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>Login</title>
<meta name="description" content="Login">
<meta name="author" content="Luke Prescott">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
</head>

<body>
	<div class="login">
		<form  action="${pageContext.request.contextPath}/Login" method="post">
			<div class="username">
				<label for="username"><i class="fas fa-user"></i></label> <input type="text" name="username" placeholder="username" required>
			</div>
			<div class="password">
				<label for="password"><i class="fas fa-lock"></i></label> <input type="password" name="password" placeholder="password" required>
			</div>
			<input type="submit" style="display: none"/>
		</form>
		
		<%
			if (request.getParameter("success") != null &&  request.getParameter("success").equals("false")) {
				out.println("<div class=\"error\"><p>Invalid login credentials.</p></div>");
			}
		%>
	</div>
</body>

</html>