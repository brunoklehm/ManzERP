<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Session"%>
<%@page import="model.ConnectionDB"%>
<%@page import="model.Usuario"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="org.hibernate.HibernateException"%>
<%@page import="model.SingletonCurrentUser"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	if (SingletonCurrentUser.getCurrentUser() != null) {
		if (SingletonCurrentUser.getUpdateUser() != null && SingletonCurrentUser.getUrl().equals("redirect")
				&& SingletonCurrentUser.getCurrentUser().getTipo() == 3) {
			Session sess = null;
			SessionFactory factory = null;
			Transaction tx = null;

			factory = ConnectionDB.getSessionFactory();
			sess = factory.getCurrentSession();

			try {
				tx = sess.beginTransaction();

				SingletonCurrentUser.getUpdateUser().setCpf(request.getParameter("cpf"));
				SingletonCurrentUser.getUpdateUser().setNome(request.getParameter("name"));
				SingletonCurrentUser.getUpdateUser().setLogin(request.getParameter("login"));
				SingletonCurrentUser.getUpdateUser().setSenha(request.getParameter("pass"));

				sess.update(SingletonCurrentUser.getUpdateUser());
				tx.commit();
			} catch (HibernateException ex) {
				if (tx != null) {
					tx.rollback();
					ex.printStackTrace();
				}
			} finally {
				sess.close();
			}

			SingletonCurrentUser.setNull();

			response.sendRedirect("list-user.jsp");
		} else {
			response.sendRedirect("list-user.jsp");
		}
	} else {
		response.sendRedirect("login.jsp");
	}
%>