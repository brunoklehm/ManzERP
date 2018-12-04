package model;

public class SingletonCurrentUser {

	private static Usuario currentUser;
	private static String url; // fazer pra que a pessoa tente uma url faça o login e volte para a página

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

}
