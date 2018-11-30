<%@page import="model.ConnectionDB"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="model.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/bulma.min.css">
</head>
<body>
	<br>
	<div class="container" style="width: 35%">
		<center>
			<section class="hero">
			<h1 class="title">Criar chamado</h1>
			</section>
		</center>
		<br>
		<form
			action="create-callT.jsp?userId=<%=request.getParameter("userId")%>"
			method="POST">
			<div class="field">
				<label class="label">Título</label>
				<div class="control">
					<input name="name" class="input" type="text"
						placeholder="Título do chamado">
				</div>
			</div>
			<div class="field">
				<label class="label">Tipo</label>
				<div class="control">
					<div class="select">
						<select name="type">
							<option value="1">Baixo</option>
							<option value="2">Moderado</option>
							<option value="3">Crítico</option>
						</select>
					</div>
				</div>
			</div>
			<div class="field">
				<label class="label">Descrição</label>
				<div class="control">
					<textarea class="textarea" style="height: 225px"
						placeholder="Descrição do chamado..." name="description"></textarea>
				</div>
			</div>
			<br>
			<div class="field-body">
				<div class="field">
					<div class="control">
						<center>
							<button class="button is-link" style="width: 45%" type="submit">Enviar</button>
						</center>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>