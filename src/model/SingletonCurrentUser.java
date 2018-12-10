package model;

public class SingletonCurrentUser {

	private static Usuario currentUser;
	private static String url; // fazer pra que a pessoa tente uma url fa�a o login e volte para a p�gina
	private static Usuario updateUser; // fazer pra atualizar o usu�rio pelo form

	public static Usuario getCurrentUser() {
		return currentUser;
	}

	public static void setCurrentUser(Usuario currentUser) {
		SingletonCurrentUser.currentUser = currentUser;
	}

	public static String getUrl() {
		return url;
	}

	public static void setUrl(String url) {
		SingletonCurrentUser.url = url;
	}

	public static Usuario getUpdateUser() {
		return updateUser;
	}

	public static void setUpdateUser(Usuario updateUser) {
		SingletonCurrentUser.updateUser = updateUser;
	}

	public static void setNull() {
		url = "";
		updateUser = null;
	}

}
