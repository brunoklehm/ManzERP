package model;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class ConnectionDB {

	private static Configuration conf = null;

	private static SessionFactory factory = null;

	private static SessionFactory buildSessionFactory() {

		try {

			conf = new Configuration();
			conf.configure("hibernate.cfg.xml");
			System.out.println("Conectado com sucesso");

			factory = conf.buildSessionFactory();
			System.out.println("SessionFactory realizada com sucesso");

			return factory;

		} catch (Exception e) {
			System.out.println("Falha na conexão");
			e.printStackTrace();

			throw new ExceptionInInitializerError(e);
		}

	}

	public static SessionFactory getSessionFactory() {

		if (factory == null) {
			factory = buildSessionFactory();
		}

		return factory;
	}
}
