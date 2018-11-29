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
</head>
<body>
	<%
		Usuario userR = new Usuario();
		userR.setLogin(request.getParameter("login"));
		userR.setSenha(request.getParameter("senha"));

		SessionFactory factory = null;
		Session sess = null;

		factory = ConnectionDB.getSessionFactory();

		sess = factory.openSession();
		List results = sess
				.createQuery("from usuario where login = " + userR.getLogin() + " and senha = " + userR.getSenha())
				.list();
		Usuario user = null;
		if (results != null) {
			user = (Usuario) results.get(0);
		} else {
			response.sendRedirect("login.jsp");
		}
	%>
	<%
		sess.clear();

		request.setAttribute("userId", user.getId());
	%>
	<nav class="navbar is-link" role="navigation"
		aria-label="dropdown navigation">
		<div class="navbar-start">
			<a class="navbar-item"> <img src="logo.png" width="50">
			</a> <a class="navbar-item" href="create-user.html"> Criar usuário </a> <a
				class="navbar-item" href="create-call.html"> Criar chamado </a> <a
				class="navbar-item" href="list-call.html"> Chamados </a> <a
				class="navbar-item" href="user-list.html"> Usuários </a>
		</div>
		<div class="navbar-end">
			<div class="navbar-item has-dropdown is-hoverable">
				<a class="navbar-link"> <img src="user.png">
				</a>
				<div class="navbar-dropdown">
					<a class="navbar-link is-primary"> <%=user.getNome()%>
					</a> <a class="navbar-item"> My account </a> <a class="navbar-item">
						Logoff </a>
				</div>
			</div>
		</div>
	</nav>
	<!--<jsp:include page="header.jsp?userId=<%=user.getId()%>"></jsp:include>-->
</body>
</html>