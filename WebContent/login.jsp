<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/particles.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/animate.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>

<body id="particles-js" style="overflow: hidden;">

	<script src="${pageContext.request.contextPath}/js/particles.js"></script>
	<script>
		/* particlesJS.load(@dom-id, @path-json, @callback (optional)); */
		particlesJS.load('particles-js', '${pageContext.request.contextPath}/json/particlesjs-config.json', function() {
		  console.log('callback - particles.js config loaded');
		});
	</script>
	
	<c:if test="${not empty param.login}">
    	<script>
	    	swal({
	    		title: "Invalid Login Credentials",
			  	icon: "error",
			});
    	</script>
	</c:if>

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
	</div>
</body>

</html>