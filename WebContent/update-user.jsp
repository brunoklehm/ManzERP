<%@page
	import="com.sun.xml.internal.bind.v2.runtime.unmarshaller.XsiNilLoader.Single"%>
<%@page import="model.ConnectionDB"%>
<%@page import="model.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Modificar usuário - Ronaldo Chamados</title>
<link rel="icon" href="img/RonaldoChamados.png">
<link rel="stylesheet" type="text/css" href="css/bulma.min.css">
</head>
<body>
	<%
		SessionFactory factory = null;
		Session sess = null;
		List results = null;

		factory = ConnectionDB.getSessionFactory();

		if (session.getAttribute("user") != null) {
			if (((Usuario) session.getAttribute("updateUser")) != null
					&& session.getAttribute("urlRedirect").equals("redirect")) {
				if (((Usuario) session.getAttribute("user")).getTipo() == 3) {
	%>
	<nav class="navbar is-link" role="navigation"
		aria-label="dropdown navigation">
		<div class="navbar-start">
			<a href="index.jsp" class="navbar-item"> <img src="img/logo.png"
				width="30">
			</a>
			<%
				if (((Usuario) session.getAttribute("user")).getTipo() == 3) {
			%><a class="navbar-item" href="create-user.jsp"> Criar usuário </a>
			<%
				}
			%>
			<%
				if (((Usuario) session.getAttribute("user")).getTipo() == 1
									|| ((Usuario) session.getAttribute("user")).getTipo() == 3) {
			%>
			<a class="navbar-item" href="create-call.jsp"> Criar chamado </a>
			<%
				}
			%>
			<a class="navbar-item" href="list-call.jsp"> Chamados </a>
			<%
				if (((Usuario) session.getAttribute("user")).getTipo() == 2
									|| ((Usuario) session.getAttribute("user")).getTipo() == 3) {
			%>
			<a class="navbar-item" href="list-user.jsp"> Usuários </a>
			<%
				}
			%>
			<%
				if (((Usuario) session.getAttribute("user")).getTipo() == 2) {
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
					<a class="navbar-item is-primary"> <%=((Usuario) session.getAttribute("user")).getNome()%>
					</a> <a href="logoff.jsp" class="navbar-item"> Logoff </a>
				</div>
			</div>
		</div>
	</nav>
	<br>
	<div class="container" style="width: 35%">
		<center>
			<section class="hero">
				<h1 class="title">Editar usuário</h1>
			</section>
		</center>
		<br>
		<form action="update-userT.jsp" method="POST">
			<div class="field">
				<label class="label">Nome</label>
				<div class="control">
					<input name="name" class="input" type="text" placeholder="Nome..."
						required
						value="<%=((Usuario) session.getAttribute("updateUser")).getNome()%>">
				</div>
			</div>
			<div class="field">
				<label class="label">CPF</label>
				<div class="control">
					<input name="cpf" class="input" type="text" placeholder="CPF..."
						maxlength="11" minlength="11" required
						value="<%=((Usuario) session.getAttribute("updateUser")).getCpf()%>">
				</div>
			</div>
			<div class="field">
				<label class="label">Login</label>
				<div class="control">
					<input name="login" class="input" type="text"
						placeholder="Login..." required
						value="<%=((Usuario) session.getAttribute("updateUser")).getLogin()%>">
				</div>
			</div>
			<div class="field">
				<label class="label">Senha</label>
				<div class="control">
					<input name="pass" class="input" type="password"
						placeholder="Senha..." required
						value="<%=((Usuario) session.getAttribute("updateUser")).getSenha()%>">
				</div>
			</div>
			<br>
			<div class="field-body">
				<div class="field">
					<div class="control">
						<center>
							<button type="submit" class="button is-link" style="width: 45%">Editar</button>
						</center>
					</div>
				</div>
			</div>
		</form>
	</div>
	<%
		} else {
					response.sendRedirect("list-user.jsp");
				}
			} else {
				response.sendRedirect("list-user.jsp");
			}
		} else {
			response.sendRedirect("login.jsp");
		}
	%>
</body>
</html>