<%@page import="model.SingletonCurrentUser"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Session"%>
<%@page import="model.ConnectionDB"%>
<%@page import="model.Chamado"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	if (SingletonCurrentUser.getCurrentUser() != null) {
		Chamado call = new Chamado();
		call.setDescricao(request.getParameter("description"));
		call.setNome(request.getParameter("name"));
		call.setStatus(1);
		call.setTipo(Integer.parseInt(request.getParameter("type")));
		call.setUsuario_solicitante(SingletonCurrentUser.getCurrentUser().getId());

		SessionFactory factory = null;
		Session sess = null;

		factory = ConnectionDB.getSessionFactory();

		sess = factory.openSession();

		sess.getTransaction().begin();
		sess.save(call);
		sess.getTransaction().commit();

		if (sess != null) {
			out.print("Chamado cadastrado com sucesso");
			response.sendRedirect("index.jsp");
		}
	} else {
		response.sendRedirect("login.jsp");
	}
%>