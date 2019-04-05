<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Home</title>
<meta name="description" content="MyNotes Home">
<meta name="author" content="Luke Prescott">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/particles.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/animate.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/12.0.0/classic/ckeditor.js"></script>
</head>
<body id="particles-js" style="overflow: hidden;">

	<script src="${pageContext.request.contextPath}/js/particles.js"></script>
	<script>
		/* particlesJS.load(@dom-id, @path-json, @callback (optional)); */
		particlesJS.load('particles-js', '${pageContext.request.contextPath}/json/particlesjs-config-nasa.json', function() {
		  console.log('callback - particles.js config loaded');
		});
	</script>
	
	<div id="main">
	
	<header>
		<div class="header-item search-item">
			<i class="fas fa-search"></i><input type="text" id="notes-filter" onkeyup="filterNotes('notes-filter')" placeholder="Filter the below notes...">
		</div>
		<div class="header-item">
			
			<form action="${pageContext.request.contextPath}/Logout" method="post">
		 		${username}
			 	<span>
				   <button type="submit" name="Logout" value="Logout" ><i class="fas fa-sign-out-alt"></i></button>
				</span>
			</form>	 	
		
		</div>
	</header>
	
	</div>
	
</body>
</html>