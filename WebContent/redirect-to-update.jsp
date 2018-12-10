<%@page import="org.hibernate.HibernateException"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="model.Usuario"%>
<%@page import="model.ConnectionDB"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Session"%>
<%@page import="model.SingletonCurrentUser"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	if (SingletonCurrentUser.getCurrentUser() != null) {
		if (SingletonCurrentUser.getCurrentUser().getTipo() == 3 && request.getParameter("id") != null) {
			Session sess = null;
			SessionFactory factory = null;
			Transaction tx = null;

			factory = ConnectionDB.getSessionFactory();
			sess = factory.getCurrentSession();

			try {
				tx = sess.beginTransaction();

				Usuario us = (Usuario) sess.get(Usuario.class, Integer.parseInt(request.getParameter("id")));

				Hibernate.initialize(us);

				SingletonCurrentUser.setUpdateUser(us);

				tx.commit();

				SingletonCurrentUser.setUrl("redirect");

				response.sendRedirect("update-user.jsp");
			} catch (HibernateException ex) {
				if (tx != null) {
					tx.rollback();
					ex.printStackTrace();
				}
			} finally {
				sess.close();
			}

		} else {
			response.sendRedirect("list-user.jsp");
		}
	} else {
		response.sendRedirect("login.jsp");
	}
%>