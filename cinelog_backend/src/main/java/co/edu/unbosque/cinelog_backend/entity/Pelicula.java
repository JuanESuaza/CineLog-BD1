package co.edu.unbosque.cinelog_backend.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "PELICULA")
public class Pelicula {

	@Id
	@Column(name = "id_contenido")
	private Integer idContenido;

	@OneToOne
	@MapsId
	@JoinColumn(name = "id_contenido")
	private Contenido contenido;

	@Column(name = "duracion_minutos", nullable = false)
	private Short duracionMinutos;

	public Integer getIdContenido() {
		return idContenido;
	}

	public void setIdContenido(Integer idContenido) {
		this.idContenido = idContenido;
	}

	public Contenido getContenido() {
		return contenido;
	}

	public void setContenido(Contenido contenido) {
		this.contenido = contenido;
	}

	public Short getDuracionMinutos() {
		return duracionMinutos;
	}

	public void setDuracionMinutos(Short duracionMinutos) {
		this.duracionMinutos = duracionMinutos;
	}
}