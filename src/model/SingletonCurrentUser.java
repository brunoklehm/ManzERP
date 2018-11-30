package model;

public class SingletonCurrentUser {

	private static Usuario currentUser;

	public static Usuario getCurrentUser() {
		return currentUser;
	}

	public static void setCurrentUser(Usuario currentUser) {
		SingletonCurrentUser.currentUser = currentUser;
	}

}
