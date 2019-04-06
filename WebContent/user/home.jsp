<%@page import="edu.albany.csi410.session.LoginEnum"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
</head>
<body>
	<div id="particles-js"></div>

	<script src="${pageContext.request.contextPath}/js/particles.js"></script>
	<script>
		/* particlesJS.load(@dom-id, @path-json, @callback (optional)); */
		particlesJS.load(
			'particles-js',
			'${pageContext.request.contextPath}/json/particlesjs-config-nasa.json',
			function() {
				console.log('callback - particles.js nasa config loaded');
		});
	</script>

	<div id="main">
		<header>
			<a id="new-link"><i id="new" class="fas fa-plus"></i></a>

			<div class="padding header-item search-item">
				<i class="fas fa-search"></i> <input type="text" id="notes-filter" onkeyup="filterNotes('notes-filter')" placeholder="Filter the below notes...">
			</div>
			<div class="padding header-item">

				<form action="${pageContext.request.contextPath}/Logout" method="post">
					${username} <span>
						<button id="logout-link" type="submit" name="Logout" value="Logout" title="Logout">
							<i id="logout" class="fas fa-sign-out-alt"></i>
						</button>
					</span>
				</form>

			</div>
		</header>

		<sql:setDataSource var="snapshot" driver="com.mysql.cj.jdbc.Driver" url="<%=LoginEnum.hostname.getValue()%>" user="<%=LoginEnum.username.getValue()%>" password="<%=LoginEnum.password.getValue()%>" />
		<sql:query dataSource="${snapshot}" var="result"> SELECT * FROM NOTES WHERE USER_ID = ${id};</sql:query>

		<div id="note-container">
			<c:forEach var="row" items="${result.rows}">
				<div class="note">
					<div style="text-align: left; font-size: 18pt;">
						<c:out value="${row.TITLE}" />
						<span style="float: right;"><a id="dropdown-link"><i id="dropdown" class="fas fa-caret-down"></i></a><a id="edit-link"><i id="edit" class="fas fa-edit"></i></a><a id="delete-link"><i id="delete" class="fas fa-times"></i></a></span>
					</div>
					<hr style="margin-left:-20px; margin-right:-20px;" >
					<p id="${row.NOTE_ID}_TEXT" style="font-size: 14pt;">
						<c:out value="${row.TEXT}" />
					</p>
				</div>
			</c:forEach>
		</div>

	</div>

</body>
</html>