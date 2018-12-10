<%@page import="model.SingletonCurrentUser"%>
<%@page import="model.ConnectionDB"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="model.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Criar chamado - ManzERP</title>
<link rel="icon" href="img/favicon.png">
<link rel="stylesheet" type="text/css" href="css/bulma.min.css">
</head>
<body>
	<%
		SessionFactory factory = null;
		Session sess = null;

		SingletonCurrentUser.setNull();

		factory = ConnectionDB.getSessionFactory();

		Usuario user = null;
		if (SingletonCurrentUser.getCurrentUser() != null) {
			if (SingletonCurrentUser.getCurrentUser().getTipo() == 1
					|| SingletonCurrentUser.getCurrentUser().getTipo() == 3) {
				user = SingletonCurrentUser.getCurrentUser();
			} else {
				response.sendRedirect("index.jsp");
			}
		} else {
			response.sendRedirect("login.jsp");
		}
	%>
	<nav class="navbar is-link" role="navigation"
		aria-label="dropdown navigation">
	<div class="navbar-start">
		<a href="index.jsp" class="navbar-item"> <img src="img/logo.png"
			width="50">
		</a>
		<%
			if (user != null) {
				if (user.getTipo() == 3) {
		%><a class="navbar-item" href="create-user.jsp"> Criar usuário </a>
		<%
			}
		%>
		<%
			if (user.getTipo() == 1 || user.getTipo() == 3) {
		%>
		<a class="navbar-item" href="create-call.jsp"> Criar chamado </a>
		<%
			}
		%>
		<a class="navbar-item" href="list-call.jsp"> Chamados </a>
		<%
			if (user.getTipo() == 2 || user.getTipo() == 3) {
		%>
		<a class="navbar-item" href="list-user.jsp"> Usuários </a>
		<%
			}
		%>
		<%
			if (user.getTipo() == 2) {
		%>
		<a class="navbar-item" href="my-calls.jsp"> Meus Chamados </a>
		<%
			}
		%>
	</div>
	<div class="navbar-end">
		<div class="navbar-item has-dropdown is-hoverable">
			<a class="navbar-link"> <img src="img/user.png">
			</a>
			<div class="navbar-dropdown">
				<a class="navbar-item is-primary"> <%=user.getNome()%> <%
 	}
 %>
				</a><a href="logoff.jsp" class="navbar-item"> Logoff </a>
			</div>
		</div>
	</div>
	</nav>
	<br>
	<div class="container" style="width: 35%">
		<center>
			<section class="hero">
			<h1 class="title">Criar chamado</h1>
			</section>
		</center>
		<br>
		<form action="create-callT.jsp" method="POST">
			<div class="field">
				<label class="label">Título</label>
				<div class="control">
					<input name="name" class="input" type="text"
						placeholder="Título do chamado">
				</div>
			</div>
			<div class="field">
				<label class="label">Tipo</label>
				<div class="control">
					<div class="select">
						<select name="type">
							<option value="1">Baixo</option>
							<option value="2">Moderado</option>
							<option value="3">Crítico</option>
						</select>
					</div>
				</div>
			</div>
			<div class="field">
				<label class="label">Descrição</label>
				<div class="control">
					<textarea class="textarea" style="height: 225px"
						placeholder="Descrição do chamado..." name="description"></textarea>
				</div>
			</div>
			<br>
			<div class="field-body">
				<div class="field">
					<div class="control">
						<center>
							<button class="button is-link" style="width: 45%" type="submit">Enviar</button>
						</center>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>