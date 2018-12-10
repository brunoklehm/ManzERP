<%@page import="org.hibernate.Query"%>
<%@page import="model.SingletonCurrentUser"%>
<%@page import="java.util.List"%>
<%@page import="model.ConnectionDB"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="model.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<title>Início - ManzERP</title>
<link rel="icon" href="img/favicon.png">
<link rel="stylesheet" type="text/css" href="css/bulma.min.css">
</head>
<body>
	<%
		SessionFactory factory = null;
		Session sess = null;
		List results = null;

		SingletonCurrentUser.setNull();

		factory = ConnectionDB.getSessionFactory();

		if (SingletonCurrentUser.getCurrentUser() == null) {
			response.sendRedirect("login.jsp");
		}
		if (SingletonCurrentUser.getCurrentUser() != null) {
	%>
	<nav class="navbar is-link" role="navigation"
		aria-label="dropdown navigation">
		<div class="navbar-start">
			<a href="index.jsp" class="navbar-item"> <img src="img/logo.png"
				width="50">
			</a>
			<%
				if (SingletonCurrentUser.getCurrentUser().getTipo() == 3) {
			%><a class="navbar-item" href="create-user.jsp"> Criar usuário </a>
			<%
				}
			%>
			<%
				if (SingletonCurrentUser.getCurrentUser().getTipo() == 1
							|| SingletonCurrentUser.getCurrentUser().getTipo() == 3) {
			%>
			<a class="navbar-item" href="create-call.jsp"> Criar chamado </a>
			<%
				}
			%>
			<a class="navbar-item" href="list-call.jsp"> Chamados </a>
			<%
				if (SingletonCurrentUser.getCurrentUser().getTipo() == 2
							|| SingletonCurrentUser.getCurrentUser().getTipo() == 3) {
			%>
			<a class="navbar-item" href="list-user.jsp"> Usuários </a>
			<%
				}
			%>
			<%
				if (SingletonCurrentUser.getCurrentUser().getTipo() == 2) {
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
					<a class="navbar-item is-primary"> <%=SingletonCurrentUser.getCurrentUser().getNome()%>
					</a> <a href="logoff.jsp" class="navbar-item"> Logoff </a>
				</div>
			</div>
		</div>
	</nav>
	<div class="container" style="margin-top: 80px">
		<div class="columns is-mobile is-centered">
			<div class="column is-half">
				<p style="text-align: center">
					<img src="img/weg-logo.jpg" alt="Logo da WEG" style="width: 50%">
				</p>
				<h1 class="title is-1" style="text-align: center; margin-top: 25px">ManzERP</h1>
				<p style="text-align: center; font-size: 18px">Bem-vindo ao
					ManzERP, o ERP de chamados desenvolvido para facilitar o
					gerenciamento de chamados entre os colaboradores da WEG.</p>
				<p style="margin-top: 50px; text-align: center; font-size: 18px">Escolha
					uma das opções na barra de navegação para usar o sistema.</p>
			</div>
		</div>
	</div>
	<%
		}
	%>
</body>
</html>