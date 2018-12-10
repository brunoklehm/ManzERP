<%@page import="model.SingletonCurrentUser"%>
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

	SingletonCurrentUser.setNull();

	factory = ConnectionDB.getSessionFactory();

	Usuario user = null;
	if (request.getParameter("login") != null && request.getParameter("senha") != null) {
		sess = factory.openSession();
		Query query = sess.createQuery("from Usuario where login = :login and senha = :senha and status = 1");

		query.setParameter("login", request.getParameter("login"));
		query.setParameter("senha", request.getParameter("senha"));
		results = query.list();
		if (results.isEmpty()) {
			response.sendRedirect("login.jsp?fail=kappa");
		} else {
			user = (Usuario) results.get(0);
			SingletonCurrentUser.setCurrentUser(user);
			sess.clear();
			response.sendRedirect("index.jsp");
		}
	} else {
		response.sendRedirect("login.jsp?fail=kappa");
	}
%>