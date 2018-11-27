package model;

public class Chamado {

	private int id;
	private int tipo;
	private String descricao;
	private int status;
	private int usuario_solicitante;
	private int usuario_atendente;

	public Chamado() {

	}

	public Chamado(int tipo, String descricao, int status, int usuario_solicitante, int usuario_atendente) {
		this.tipo = tipo;
		this.descricao = descricao;
		this.status = status;
		this.usuario_solicitante = usuario_solicitante;
		this.usuario_atendente = usuario_atendente;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getTipo() {
		return tipo;
	}

	public void setTipo(int tipo) {
		this.tipo = tipo;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getUsuario_solicitante() {
		return usuario_solicitante;
	}

	public void setUsuario_solicitante(int usuario_solicitante) {
		this.usuario_solicitante = usuario_solicitante;
	}

	public int getUsuario_atendente() {
		return usuario_atendente;
	}

	public void setUsuario_atendente(int usuario_atendente) {
		this.usuario_atendente = usuario_atendente;
	}

}
