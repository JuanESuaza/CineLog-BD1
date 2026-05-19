package co.edu.unbosque.cinelog_backend.dto;

import java.math.BigDecimal;

public class CalificacionRequest {

	private Integer id_contenido;
	private BigDecimal puntuacion;

	private String resenia;
	private String resena;

	public CalificacionRequest() {
	}

	public Integer getId_contenido() {
		return id_contenido;
	}

	public void setId_contenido(Integer id_contenido) {
		this.id_contenido = id_contenido;
	}

	public BigDecimal getPuntuacion() {
		return puntuacion;
	}

	public void setPuntuacion(BigDecimal puntuacion) {
		this.puntuacion = puntuacion;
	}

	public String getResenia() {
		if (resenia != null && !resenia.isBlank()) {
			return resenia;
		}
		return resena;
	}

	public void setResenia(String resenia) {
		this.resenia = resenia;
	}

	public String getResena() {
		return resena;
	}

	public void setResena(String resena) {
		this.resena = resena;
	}
}