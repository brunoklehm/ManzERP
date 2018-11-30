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
<link rel="stylesheet" type="text/css" href="css/bulma.min.css">
</head>
<body>
	<%
		SessionFactory factory = null;
		Session sess = null;
		List results = null;

		factory = ConnectionDB.getSessionFactory();

		Usuario user = null;
		Usuario userR = new Usuario();
		if ((request.getParameter("login") == null || request.getParameter("senha") == null)
				&& request.getParameter("userId") == null) {
			out.print("entrou no if");
			response.sendRedirect("login2.jsp");
		} else {
			if (request.getParameter("login") != null) {
				userR.setLogin(request.getParameter("login"));
				userR.setSenha(request.getParameter("senha"));

				sess = factory.openSession();
				results = sess.createQuery(
						"from Usuario where login = " + userR.getLogin() + " and senha = " + userR.getSenha())
						.list();
			} else if (request.getParameter("userId") != null) {

				userR.setId(Integer.parseInt(request.getParameter("userId")));
				sess = factory.openSession();
				results = sess.createQuery("from Usuario where id = " + userR.getId()).list();
			}
			if (results.isEmpty()) {
				response.sendRedirect("login.jsp");
			}
			user = (Usuario) results.get(0);

			sess.clear();
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
			<a class="navbar-item"
				href="create-call?userId=<%=user.getId()%>.jsp"> Criar chamado </a>
			<%
				}
			%>
			<%
				if (user.getTipo() == 2 || user.getTipo() == 3) {
			%><a class="navbar-item" href="list-call.jsp"> Chamados </a> <a
				class="navbar-item" href="user-list.jsp"> Usuários </a>
			<%
				}
			%>
		</div>
		<div class="navbar-end">
			<div class="navbar-item has-dropdown is-hoverable">
				<a class="navbar-link"> <img src="img/user.png">
				</a>
				<div class="navbar-dropdown">
					<a class="navbar-link is-primary"> <%=user.getNome()%>
					</a> <a class="navbar-item"> My account </a> <a class="navbar-item">
						Logoff </a>
				</div>
			</div>
		</div>
		<%
			}
		%>
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
</body>
</html>