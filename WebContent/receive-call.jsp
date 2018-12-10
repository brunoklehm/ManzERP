<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.HibernateException"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="model.Chamado"%>
<%@page import="model.ConnectionDB"%>
<%@page import="model.SingletonCurrentUser"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	SingletonCurrentUser.setNull();
	if (SingletonCurrentUser.getCurrentUser() != null) {
		if (SingletonCurrentUser.getCurrentUser().getTipo() == 2 && request.getParameter("id") != null) {
			Session sess = null;
			SessionFactory factory = null;
			Transaction tx = null;

			factory = ConnectionDB.getSessionFactory();
			sess = factory.getCurrentSession();

			try {
				tx = sess.beginTransaction();

				Chamado ch = (Chamado) sess.get(Chamado.class, Integer.parseInt(request.getParameter("id")));

				Hibernate.initialize(ch);

				ch.setUsuario_atendente(SingletonCurrentUser.getCurrentUser().getId());

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

			response.sendRedirect("list-call.jsp");
		} else {
			response.sendRedirect("list-call.jsp");
		}
	} else {
		response.sendRedirect("login.jsp");
	}
%>