package co.edu.unbosque.cinelog_backend.dto;

public class CalificacionRequest {

	private Integer id_contenido;
	private Integer puntuacion;
	private String resenia;

	public CalificacionRequest() {
	}

	public Integer getId_contenido() {
		return id_contenido;
	}

	public void setId_contenido(Integer id_contenido) {
		this.id_contenido = id_contenido;
	}

	public Integer getPuntuacion() {
		return puntuacion;
	}

	public void setPuntuacion(Integer puntuacion) {
		this.puntuacion = puntuacion;
	}

	public String getResenia() {
		return resenia;
	}

	public void setResenia(String resenia) {
		this.resenia = resenia;
	}
}