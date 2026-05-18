package co.edu.unbosque.cinelog_backend.dto;

public class UsuarioResponse {

	private Integer id;
	private String nombre_usuario;
	private String primer_nombre;
	private String primer_apellido;
	private String correo_electronico;

	public UsuarioResponse() {
	}

	public UsuarioResponse(Integer id, String nombre_usuario, String primer_nombre, String primer_apellido,
			String correo_electronico) {
		this.id = id;
		this.nombre_usuario = nombre_usuario;
		this.primer_nombre = primer_nombre;
		this.primer_apellido = primer_apellido;
		this.correo_electronico = correo_electronico;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNombre_usuario() {
		return nombre_usuario;
	}

	public void setNombre_usuario(String nombre_usuario) {
		this.nombre_usuario = nombre_usuario;
	}

	public String getPrimer_nombre() {
		return primer_nombre;
	}

	public void setPrimer_nombre(String primer_nombre) {
		this.primer_nombre = primer_nombre;
	}

	public String getPrimer_apellido() {
		return primer_apellido;
	}

	public void setPrimer_apellido(String primer_apellido) {
		this.primer_apellido = primer_apellido;
	}

	public String getCorreo_electronico() {
		return correo_electronico;
	}

	public void setCorreo_electronico(String correo_electronico) {
		this.correo_electronico = correo_electronico;
	}
}