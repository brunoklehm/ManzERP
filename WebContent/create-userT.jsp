<%@page import="model.ConnectionDB"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="model.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	Usuario user = new Usuario();
	user.setCpf(request.getParameter("cpf"));
	user.setNome(request.getParameter("name"));
	user.setTipo(Integer.parseInt(request.getParameter("type")));
	user.setLogin(request.getParameter("login"));
	user.setSenha(request.getParameter("pass"));

	SessionFactory factory = null;
	Session sess = null;

	factory = ConnectionDB.getSessionFactory();

	sess = factory.openSession();

	sess.getTransaction().begin();
	sess.save(user);
	sess.getTransaction().commit();

	if (sess != null) {
		out.print("Usuário cadastrado com sucesso");
		response.sendRedirect("index.jsp");
	}
%>