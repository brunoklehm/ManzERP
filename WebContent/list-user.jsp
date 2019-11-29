<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.HibernateException"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="model.Usuario"%>
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
<title>Listar usuários - Ronaldo Chamados</title>
<link rel="icon" href="img/RonaldoChamados.png">
<link rel="stylesheet" type="text/css" href="css/bulma.min.css">
</head>
<body>
	<%
		SessionFactory factory = null;
		Session sess = null;
		Transaction tx = null;

		session.setAttribute("updateUser", null);
		session.setAttribute("urlRedirect", "");

		factory = ConnectionDB.getSessionFactory();

		Usuario user = null;
		if (session.getAttribute("user") != null) {
			if (((Usuario) session.getAttribute("user")).getTipo() == 2
					|| ((Usuario) session.getAttribute("user")).getTipo() == 3) {
				user = ((Usuario) session.getAttribute("user"));
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
			width="30">
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
		<br> <input id="inputCall" type="text" onkeyup="functionSearch()"
			placeholder="Pesquisar por Nome" class="input is-rounded"
			style="max-width: 200px;"> <br>
		<br>
		<table
			class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth"
			id="tableCalls">
			<thead>
				<tr>
					<th>ID</th>
					<th>Nome</th>
					<th>CPF</th>
					<th>Login</th>
					<%
						if (((Usuario) session.getAttribute("user")).getTipo() == 3) {
					%>
					<th>Senha</th>
					<%
						}
					%>
					<th>Tipo</th>
					<th>Status</th>
					<%
						if (((Usuario) session.getAttribute("user")).getTipo() == 3) {
					%>
					<th style="text-align: center">Alterar/Ativar</th>
					<th style="text-align: center">Excluir</th>
					<%
						}
					%>
				</tr>
			</thead>
			<%
				factory = ConnectionDB.getSessionFactory();
					sess = factory.getCurrentSession();
					try {
						tx = sess.beginTransaction();
						List usuarios = sess.createQuery("from Usuario order by status desc, tipo desc, id desc").list();
						for (Iterator iterator = usuarios.iterator(); iterator.hasNext();) {
							Usuario us = (Usuario) iterator.next();
			%>
			<tbody>
				<tr>
					<td><%=us.getId()%></td>
					<td><%=us.getNome()%></td>
					<td><%=us.getCpf()%></td>
					<td><%=us.getLogin()%></td>
					<%
						if (((Usuario) session.getAttribute("user")).getTipo() == 3) {
					%>
					<td><%=us.getSenha()%></td>
					<%
						}
					%>
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
					<%
						if (((Usuario) session.getAttribute("user")).getTipo() == 3) {
					%>
					<td>
						<%
							if (us.getStatus() == 1) {
						%> <a href="redirect-to-update.jsp?id=<%=us.getId()%>"
						title="Alterar"><center>
								<img src="img/lapis.png" style="width: 12px"></a> <%
 	} else {
 %> <a href="activate-user.jsp?id=<%=us.getId()%>" title="Ativar"><center>
								<img src="img/correto.png" style="width: 12px"></a> <%
 	}
 %>
					</td>
					<td>
						<%
							if (((Usuario) session.getAttribute("user")).getId() != us.getId()) {
						%> <a href="exclude-user.jsp?id=<%=us.getId()%>" title="Excluir"><center>
								<img src="img/lixeira.png" style="width: 12px"></a>
					</td>
					<%
						}
									}
					%>
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
	<script>
		function functionSearch() {
			// Declare variables
			var input, filter, table, tr, td, i, txtValue;
			input = document.getElementById("inputCall");
			filter = input.value.toUpperCase();
			table = document.getElementById("tableCalls");
			tr = table.getElementsByTagName("tr");

			// Loop through all table rows, and hide those who don't match the search query
			for (i = 0; i < tr.length; i++) {
				td = tr[i].getElementsByTagName("td")[1];
				if (td) {
					txtValue = td.textContent || td.innerText;
					if (txtValue.toUpperCase().includes(filter)) {
						tr[i].style.display = "";
					} else {
						tr[i].style.display = "none";
					}
				}

			}
		}
	</script>
</body>
</html>