<%@page import="org.hibernate.Hibernate"%>
<%@page import="org.hibernate.HibernateException"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="model.Chamado"%>
<%@page import="model.Usuario"%>
<%@page import="model.Usuario"%>
<%@page import="model.ConnectionDB"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listar chamados - ManzERP</title>
<link rel="icon" href="img/favicon.png">
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

		if (session.getAttribute("user") == null) {
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
			if (((Usuario) session.getAttribute("user")) != null) {
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
				</a><a href="logoff.jsp" class="navbar-item"> Logoff </a>
			</div>
		</div>
	</div>
	</nav>
	<br>
	<div class="container">
		<center>
			<section class="hero">
			<h1 class="title">Chamados</h1>
			</section>
		</center>
		<br>
		<table
			class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
			<thead>
				<tr>
					<th>ID</th>
					<%
						if (((Usuario) session.getAttribute("user")).getTipo() != 1) {
					%>
					<th>Solicitante</th>
					<%
						}
					%>
					<%
						if (((Usuario) session.getAttribute("user")).getTipo() != 2) {
					%>
					<th>Atendente</th>
					<%
						}
					%>
					<th>Título</th>
					<th>Descrição</th>
					<th>Tipo</th>
					<th>Status</th>
					<%
						if (((Usuario) session.getAttribute("user")).getTipo() == 2) {
					%>
					<th style="text-align: center">Atender</th>
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
						List chamados = null;
						if (((Usuario) session.getAttribute("user")).getTipo() == 1) {
							chamados = sess.createQuery("from Chamado where usuario_solicitante = "
									+ ((Usuario) session.getAttribute("user")).getId() + " order by status desc, id desc")
									.list();
						} else if (((Usuario) session.getAttribute("user")).getTipo() == 2) {
							chamados = sess.createQuery(
									"from Chamado where status = 1 order by usuario_atendente asc, tipo desc, id desc")
									.list();
						} else {
							chamados = sess.createQuery("from Chamado order by id desc").list();
						}

						for (Iterator iterator = chamados.iterator(); iterator.hasNext();) {
							Chamado ch = (Chamado) iterator.next();

							sess.clear();

							Usuario solicitante = (Usuario) sess.load(Usuario.class, ch.getUsuario_solicitante());
							Hibernate.initialize(solicitante);
							sess.clear();
							Usuario atendente = null;
							if (ch.getUsuario_atendente() != 0) {
								atendente = (Usuario) sess.load(Usuario.class, ch.getUsuario_atendente());
								Hibernate.initialize(atendente);
							}
			%>
			<tbody>
				<tr>
					<td><%=ch.getId()%></td>
					<%
						if (((Usuario) session.getAttribute("user")).getTipo() != 1) {
					%>
					<td><%=solicitante.getLogin()%></td>
					<%
						}
					%>
					<%
						if (((Usuario) session.getAttribute("user")).getTipo() != 2 && atendente != null) {
					%>
					<td><%=atendente.getLogin()%></td>
					<%
						} else if (((Usuario) session.getAttribute("user")).getTipo() != 2) {
					%><td>Fila de espera</td>
					<%
						}
					%>
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
						%>Resolvido<%
							}
						%>
					</td>
					<%
						if (((Usuario) session.getAttribute("user")).getTipo() == 2) {
					%>
					<td>
						<%
							if (atendente == null) {
						%><center>
							<a class="button is-link"
								href="receive-call.jsp?id=<%=ch.getId()%>" style="height: 25px">Atender</a>
						</center> <%
 	} else {
 %> Ja foi atendido <%
 	}
 %>
					</td>
					<%
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
</body>
</html>