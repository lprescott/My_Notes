<%@page import="edu.albany.csi410.session.LoginEnum"%>
<%@page import="java.io.*,java.util.*,java.sql.*"%>
<%@page import="javax.servlet.http.*,javax.servlet.*"%>
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
<script src="${pageContext.request.contextPath}/js/main.js"></script>

</head>
<body onload="setTextareaHeight();">
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

	<c:choose>
		<c:when test="${result == 'create_success'}">
			<script>swal("Success", "You created a new note.", "success");</script>
		</c:when>
		<c:when test="${result == 'create_error'}">
			<script>swal("Error", "The note could not be created", "error");</script>
		</c:when>
		<c:when test="${result == 'edit_success'}">
			<script>swal("Success", "You edited a note.", "success");</script>
		</c:when>
		<c:when test="${result == 'edit_error'}">
			<script>swal("Error", "The note could not be edited.", "error");</script>
		</c:when>
		<c:when test="${result == 'delete_success'}">
			<script>swal("Success", "You deleted a note.", "success");</script>
		</c:when>
		<c:when test="${result == 'delete_error'}">
			<script>swal("Error", "The note could not be deleted.", "error");</script>
		</c:when>
		<c:when test="${result == 'unknown_error'}">
			<script>swal("Error", "An unknown error occured.", "error");</script>
		</c:when>
	</c:choose>

	<div id="main">
		<header>
			<a id="new-link" onclick="viewNewNote()"><i id="new" class="fas fa-plus"></i></a>

			<div class="padding header-item search-item">
				<i class="fas fa-search"></i> <input type="text" id="notes-filter" onkeyup="filterNotes('notes-filter')" placeholder="Filter the below notes...">
			</div>
			<div class="padding header-item">

				<form action="${pageContext.request.contextPath}/Logout" method="post">
					${username} <span>
						<button class="logout-link" type="submit" name="Logout" value="Logout" title="Logout">
							<i class="logout fas fa-sign-out-alt"></i>
						</button>
					</span>
				</form>

			</div>
		</header>

		<sql:setDataSource var="snapshot" driver="com.mysql.cj.jdbc.Driver" url="<%=LoginEnum.hostname.getValue()%>" user="<%=LoginEnum.username.getValue()%>" password="<%=LoginEnum.password.getValue()%>" />
		<sql:query dataSource="${snapshot}" var="result"> SELECT * FROM NOTES WHERE USER_ID = ${id};</sql:query>

		<div id="note-container">

			<form action="${pageContext.request.contextPath}/CreateNote" method="post">
				<input id="USER_ID" type="hidden" name="USER_ID" value="${id}">
				<div class="note" id="new_note" style="display: none;">
					<div style="text-align: left;">
						<input id="note-title" name="note-title" style="font-size: 18pt; color: rgb(105, 109, 119);" class="note-title" placeholder="New Note" required> <span style="float: right;"> <input type="submit" style="display: none" />
							<button class="save-link" type="submit" name="save" title="save">
								<i class="save fas fa-save"></i>
							</button> <a onclick="hideNewNote()" class="delete-link"><i class="delete fas fa-times"></i></a>
						</span>
					</div>
					<hr style="margin-left: -20px; margin-right: -20px;">
					<textarea id="new_note_textarea" name="new_note_textarea" style="font-size: 15pt; color: rgb(105, 109, 119);" onkeyup="auto_grow(this)" class="note-text" placeholder="Content" required></textarea>
					<script>
			         function auto_grow(element) {
			             element.style.height = "5px";
			             element.style.height = (element.scrollHeight)+"px";
			         }
			      </script>
				</div>
			</form>

			<c:forEach var="row" items="${result.rows}">
				<form id="${row.NOTE_ID}_form" action="${pageContext.request.contextPath}/EditNote" method="post">
					<input id="USER_ID" type="hidden" name="USER_ID" value="${id}"> <input id="NOTE_ID" type="hidden" name="NOTE_ID" value="${row.NOTE_ID}">
					<div class="note" id="${row.NOTE_ID}_note">
						<div style="text-align: left;">
							<input id="note-title" name="note-title" style="font-size: 18pt; color: rgb(105, 109, 119);" class="note-title" value="${row.TITLE}" required> <span style="float: right;"> <a onclick="viewTextArea(${row.NOTE_ID})" class="dropdown-link"> <i class="${row.TITLE}_dropdown fas fa-caret-down dropdown"> </i>
							</a>
								<button class="save-link" type="submit" name="update" title="update">
									<i class="save fas fa-save"></i>
								</button>
								<button class="delete-link" type="submit" name="delete" title="delete" formaction="${pageContext.request.contextPath}/DeleteNote">
									<i class="delete fas fa-times"></i>
								</button>
							</span>
						</div>
						<hr style="margin-left: -20px; margin-right: -20px;">
						<textarea id="${row.NOTE_ID}_textarea" name="${row.NOTE_ID}_textarea" style="font-size: 15pt; color: rgb(105, 109, 119);" onkeyup="auto_grow(this)" class="note-text" required><c:out value="${row.TEXT}" /></textarea>
						<div id="${row.NOTE_ID}_ellipsis" style="display: none; text-align: center; color: rgb(198, 201, 206);">
							<i class="fas fa-ellipsis-v"></i>
						</div>
					</div>
				</form>
			</c:forEach>
		</div>

	</div>

</body>
</html>