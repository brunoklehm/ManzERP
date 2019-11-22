<%@page import="org.hibernate.HibernateException"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="model.Usuario"%>
<%@page import="model.ConnectionDB"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Session"%>
<%@page import="model.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	if (session.getAttribute("user") != null) {
		if (((Usuario) session.getAttribute("user")).getTipo() == 3 && request.getParameter("id") != null) {
			Session sess = null;
			SessionFactory factory = null;
			Transaction tx = null;

			factory = ConnectionDB.getSessionFactory();
			sess = factory.getCurrentSession();

			try {
				tx = sess.beginTransaction();

				Usuario us = (Usuario) sess.get(Usuario.class, Integer.parseInt(request.getParameter("id")));

				Hibernate.initialize(us);

				session.setAttribute("updateUser", us);

				tx.commit();

				session.setAttribute("urlRedirect", "redirect");

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