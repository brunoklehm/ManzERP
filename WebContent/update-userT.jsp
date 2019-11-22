<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Session"%>
<%@page import="model.ConnectionDB"%>
<%@page import="model.Usuario"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="org.hibernate.HibernateException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	if (session.getAttribute("user") != null) {
		if (((Usuario) session.getAttribute("updateUser")) != null && session.getAttribute("urlRedirect").equals("redirect")
				&& ((Usuario) session.getAttribute("user")).getTipo() == 3) {
			Session sess = null;
			SessionFactory factory = null;
			Transaction tx = null;

			factory = ConnectionDB.getSessionFactory();
			sess = factory.getCurrentSession();

			try {
				tx = sess.beginTransaction();

				((Usuario) session.getAttribute("updateUser")).setCpf(request.getParameter("cpf"));
				((Usuario) session.getAttribute("updateUser")).setNome(request.getParameter("name"));
				((Usuario) session.getAttribute("updateUser")).setLogin(request.getParameter("login"));
				((Usuario) session.getAttribute("updateUser")).setSenha(request.getParameter("pass"));

				sess.update(((Usuario) session.getAttribute("updateUser")));
				tx.commit();
			} catch (HibernateException ex) {
				if (tx != null) {
					tx.rollback();
					ex.printStackTrace();
				}
			} finally {
				sess.close();
			}

			
			session.setAttribute("updateUser", null);
			session.setAttribute("urlRedirect", "");

			response.sendRedirect("list-user.jsp");
		} else {
			response.sendRedirect("list-user.jsp");
		}
	} else {
		response.sendRedirect("login.jsp");
	}
%>