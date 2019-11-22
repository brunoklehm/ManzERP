<%@page import="model.ConnectionDB"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login - ManzERP</title>
<link rel="icon" href="img/favicon.png">
<link rel="stylesheet" type="text/css" href="css/bulma.min.css">
</head>
<body>
	<%
		ConnectionDB.getSessionFactory();
		if (session.getAttribute("user") == null) {
	%>
	<form method="post" action="set-user-data.jsp">
		<div class="container" style="margin-top: 200px">
			<div class="columns is-mobile is-centered">
				<div class="column is-one-quarter">
					<h1 class="title" style="text-align: center">Login</h1>
					<%
						boolean incorrectLogin;
							if (session.getAttribute("incorrectLogin") != null) {
								incorrectLogin = (Boolean) session.getAttribute("incorrectLogin");
							} else {
								incorrectLogin = false;
							}
							if (incorrectLogin) {
					%>
					<article class="message is-danger">
					<div class="message-body">Incorrect Login</div>
					</article>
					<%
						}
					%>
					<div class="field">
						<div class="control">
							<input class="input is-rounded" type="text" placeholder="Usuário"
								name="login" required />
						</div>
					</div>
					<div class="field">
						<div class="control">
							<input class="input is-rounded" type="password"
								placeholder="Senha" name="senha" required />
						</div>
					</div>
					<button class="button is-link is-rounded" style="width: 100%"
						type="submit">Entrar</button>
				</div>
			</div>
		</div>
	</form>
	<%
		} else {
			response.sendRedirect("index.jsp");
		}
	%>

</body>
</html>