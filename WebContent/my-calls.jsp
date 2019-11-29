<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.HibernateException"%>
<%@page import="java.util.Iterator"%>
<%@page import="model.Chamado"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="model.Usuario"%>
<%@page import="org.hibernate.Query"%>
<%@page import="model.Usuario"%>
<%@page import="model.ConnectionDB"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Meus chamados - Ronaldo Chamados</title>
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
			if (((Usuario) session.getAttribute("user")).getTipo() == 2) {
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
				<a class="navbar-item is-primary"> <%=((Usuario) session.getAttribute("user")).getNome()%>
					<%
						}
					%>
				</a><a href="logoff.jsp" class="navbar-item"> Logoff </a>
			</div>
		</div>
	</div>
	</nav>
	<br>
	<div class="container">
		<center>
			<section class="hero">
			<h1 class="title">Meus chamados</h1>
			</section>
		</center>
		<br> <input id="inputCall" type="text" onkeyup="functionSearch()"
			placeholder="Pesquisar por ID" class="input is-rounded"
			style="max-width: 150px;"> <br>
		<br>
		<table
			class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth"
			id="tableCalls">
			<thead>
				<tr>
					<th>ID</th>
					<th>Solicitante</th>
					<th>Título</th>
					<th>Descrição</th>
					<th>Tipo</th>
					<th>Status</th>
					<th>Resolver</th>
				</tr>
			</thead>
			<%
				factory = ConnectionDB.getSessionFactory();
				sess = factory.getCurrentSession();
				try {
					tx = sess.beginTransaction();
					List chamados = null;
					chamados = sess.createQuery("from Chamado where usuario_atendente = "
							+ ((Usuario) session.getAttribute("user")).getId() + " order by status desc, tipo desc, id asc")
							.list();

					for (Iterator iterator = chamados.iterator(); iterator.hasNext();) {
						Chamado ch = (Chamado) iterator.next();

						sess.clear();

						Usuario solicitante = (Usuario) sess.load(Usuario.class, ch.getUsuario_solicitante());
						Hibernate.initialize(solicitante);
			%>
			<tbody>
				<tr>
					<td><%=ch.getId()%></td>
					<td><%=solicitante.getLogin()%></td>
					<td><%=ch.getNome()%></td>
					<td><%=ch.getDescricao()%></td>
					<td>
						<%
							if (ch.getTipo() == 1) {
						%>Baixo<%
							} else if (ch.getTipo() == 2) {
						%>Moderado<%
							} else if (ch.getTipo() == 3) {
						%>Crítico <%
							}
						%>
					</td>
					<td>
						<%
							if (ch.getStatus() == 1) {
						%>Ativo<%
							} else {
						%>Inativo<%
							}
						%>
					</td>
					<td>
						<%
							if (ch.getStatus() == 1) {
						%>
						<center>
							<a href="resolve-call.jsp?id=<%=ch.getId()%>"
								class="button is-link" style="height: 25px">Resolver</a>
						</center> <%
 	} else {
 %> Resolvido <%
 	}
 %>
					</td>
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
				td = tr[i].getElementsByTagName("td")[0];
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