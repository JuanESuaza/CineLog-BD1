package co.edu.unbosque.cinelog_backend.security;

public class AuthUser {

	private Integer idUsuario;
	private String correoElectronico;

	public AuthUser() {
	}

	public AuthUser(Integer idUsuario, String correoElectronico) {
		this.idUsuario = idUsuario;
		this.correoElectronico = correoElectronico;
	}

	public Integer getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(Integer idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getCorreoElectronico() {
		return correoElectronico;
	}

	public void setCorreoElectronico(String correoElectronico) {
		this.correoElectronico = correoElectronico;
	}
}