<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	session.setAttribute("user", null);

	response.sendRedirect("login.jsp");
%>
