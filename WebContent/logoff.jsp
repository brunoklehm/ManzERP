<%@page import="model.SingletonCurrentUser"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	SingletonCurrentUser.setCurrentUser(null);

	response.sendRedirect("login.jsp");
%>
