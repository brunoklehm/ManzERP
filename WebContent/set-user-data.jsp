<%@page import="org.hibernate.Query"%>
<%@page import="model.Usuario"%>
<%@page import="model.ConnectionDB"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	SessionFactory factory = null;
	Session sess = null;
	List results = null;

	session.setAttribute("updateUser", null);
	session.setAttribute("urlRedirect", "");

	factory = ConnectionDB.getSessionFactory();

	Usuario user = null;
	if (request.getParameter("login") != null && request.getParameter("senha") != null) {
		sess = factory.openSession();
		Query query = sess.createQuery("from Usuario where login = :login and senha = :senha and status = 1");

		query.setParameter("login", request.getParameter("login"));
		query.setParameter("senha", request.getParameter("senha"));
		results = query.list();
		if (results.isEmpty()) {
			session.setAttribute("incorrectLogin", true);
			response.sendRedirect("login.jsp");
		} else {
			user = (Usuario) results.get(0);
			session.setAttribute("user", user);
			sess.clear();
			response.sendRedirect("index.jsp");
		}
	} else {
		session.setAttribute("incorrectLogin", true);
		response.sendRedirect("login.jsp");
	}
%>