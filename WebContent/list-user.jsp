<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.HibernateException"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="model.SingletonCurrentUser"%>
<%@page import="model.Usuario"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="model.ConnectionDB"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listar chamados - ManzERP</title>
<link rel="stylesheet" type="text/css" href="css/bulma.min.css">
</head>
<body>
	<%
		SessionFactory factory = null;
		Session sess = null;
		Transaction tx = null;

		factory = ConnectionDB.getSessionFactory();

		Usuario user = null;
		if (SingletonCurrentUser.getCurrentUser() != null) {
			if (SingletonCurrentUser.getCurrentUser().getTipo() == 2
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
				<a class="navbar-item is-primary"> <%=user.getNome()%>
				</a><a href="logoff.jsp" class="navbar-item"> Logoff </a>
			</div>
		</div>
	</div>
	</nav>
	<br>
	<div class="container">
		<center>
			<section class="hero">
			<h1 class="title">Usuários</h1>
			</section>
		</center>
		<br>
		<table
			class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
			<thead>
				<tr>
					<th>ID</th>
					<th>Nome</th>
					<th>CPF</th>
					<th>Login</th>
					<th>Senha</th>
					<th>Tipo</th>
					<th>Status</th>
					<th style="text-align: center">Alterar</th>
					<th style="text-align: center">Excluir</th>
				</tr>
			</thead>
			<%
				factory = ConnectionDB.getSessionFactory();
					sess = factory.getCurrentSession();
					try {
						tx = sess.beginTransaction();
						List usuarios = sess.createQuery("from Usuario").list();
						for (Iterator iterator = usuarios.iterator(); iterator.hasNext();) {
							Usuario us = (Usuario) iterator.next();
			%>
			<tbody>
				<tr>
					<td><%=us.getId()%></td>
					<td><%=us.getNome()%></td>
					<td><%=us.getCpf()%></td>
					<td><%=us.getLogin()%></td>
					<td><%=us.getSenha()%></td>
					<td>
						<%
							if (us.getTipo() == 1) {
						%>Colaborador<%
							} else if (us.getTipo() == 2) {
						%>Suporte<%
							} else if (us.getTipo() == 3) {
						%>Administrador <%
							}
						%>
					</td>
					<td>
						<%
							if (us.getStatus() == 1) {
						%>Ativo<%
							} else {
						%>Inativo<%
							}
						%>
					</td>
					<td><a href="edit-user.jsp" title="Alterar"><center>
								<img src="img/lapis.png" style="width: 12px"></a></td>
					<td><a href="exclude-user.jsp" title="Excluir"><center>
								<img src="img/lixeira.png" style="width: 12px"></a></td>
				</tr>
			<tbody>
				<%
					}
							tx.commit();
						} catch (HibernateException ex) {
							if (tx != null) {
								tx.rollback();
								ex.printStackTrace();
							}
						} finally {
							sess.close();
						}
				%>
			
		</table>
	</div>
	<%
		}
	%>
</body>
</html>