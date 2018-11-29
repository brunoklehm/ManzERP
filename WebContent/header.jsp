
<%
	sess.clear();
	Usuario user = sess.load(Usuario.class, request.getParameter("userId"));

	request.setAttribute("userId", user.getId());
%>
<nav class="navbar is-link" role="navigation"
	aria-label="dropdown navigation">
	<div class="navbar-start">
		<a class="navbar-item"> <img src="logo.png" width="50">
		</a> <a class="navbar-item" href="create-user.html"> Criar usuário </a> <a
			class="navbar-item" href="create-call.html"> Criar chamado </a> <a
			class="navbar-item" href="list-call.html"> Chamados </a> <a
			class="navbar-item" href="user-list.html"> Usuários </a>
	</div>
	<div class="navbar-end">
		<div class="navbar-item has-dropdown is-hoverable">
			<a class="navbar-link"> <img src="user.png">
			</a>
			<div class="navbar-dropdown">
				<a class="navbar-link is-primary"> <%=user.getNome()%>
				</a> <a class="navbar-item"> My account </a> <a class="navbar-item">
					Logoff </a>
			</div>
		</div>
	</div>
</nav>