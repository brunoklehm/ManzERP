package model;

public class Usuario {
	private int id;
	private String nome;
	private String cpf;
	private int tipo;
	private int status;
	private String login;
	private String senha;

	public Usuario() {

	}

	public Usuario(String nome, String cpf, int tipo, String login, String senha, int status) {
		this.nome = nome;
		this.cpf = cpf;
		this.tipo = tipo;
		this.login = login;
		this.senha = senha;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public int getTipo() {
		return tipo;
	}

	public void setTipo(int tipo) {
		this.tipo = tipo;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
