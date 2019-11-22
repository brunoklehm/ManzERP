<%@page import="org.hibernate.HibernateException"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="model.Chamado"%>
<%@page import="model.ConnectionDB"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Session"%>
<%@page import="model.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	session.setAttribute("updateUser", null);
	session.setAttribute("urlRedirect", "");
	if (session.getAttribute("user") != null) {
		if (((Usuario) session.getAttribute("user")).getTipo() == 2 && request.getParameter("id") != null) {
			Session sess = null;
			SessionFactory factory = null;
			Transaction tx = null;

			factory = ConnectionDB.getSessionFactory();
			sess = factory.getCurrentSession();

			try {
				tx = sess.beginTransaction();

				Chamado ch = (Chamado) sess.get(Chamado.class, Integer.parseInt(request.getParameter("id")));

				Hibernate.initialize(ch);

				ch.setStatus(0);

				sess.clear();

				sess.update(ch);

				tx.commit();
			} catch (HibernateException ex) {
				if (tx != null) {
					tx.rollback();
					ex.printStackTrace();
				}
			} finally {
				sess.close();
			}

			response.sendRedirect("my-calls.jsp");
		} else {
			response.sendRedirect("my-calls.jsp");
		}
	} else {
		response.sendRedirect("login.jsp");
	}
%>