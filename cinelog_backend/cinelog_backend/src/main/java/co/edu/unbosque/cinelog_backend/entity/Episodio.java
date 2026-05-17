package co.edu.unbosque.cinelog_backend.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "EPISODIO")
public class Episodio {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_episodio")
	private Integer idEpisodio;

	@Column(name = "numero_episodio", nullable = false)
	private Short numeroEpisodio;

	@Column(name = "titulo", nullable = false)
	private String titulo;

	@Column(name = "duracion_minutos")
	private Short duracionMinutos;

	@Column(name = "fecha_emision")
	private LocalDate fechaEmision;

	@ManyToOne
	@JoinColumn(name = "id_temporada", nullable = false)
	private Temporada temporada;

	public Integer getIdEpisodio() {
		return idEpisodio;
	}

	public void setIdEpisodio(Integer idEpisodio) {
		this.idEpisodio = idEpisodio;
	}

	public Short getNumeroEpisodio() {
		return numeroEpisodio;
	}

	public void setNumeroEpisodio(Short numeroEpisodio) {
		this.numeroEpisodio = numeroEpisodio;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public Short getDuracionMinutos() {
		return duracionMinutos;
	}

	public void setDuracionMinutos(Short duracionMinutos) {
		this.duracionMinutos = duracionMinutos;
	}

	public LocalDate getFechaEmision() {
		return fechaEmision;
	}

	public void setFechaEmision(LocalDate fechaEmision) {
		this.fechaEmision = fechaEmision;
	}

	public Temporada getTemporada() {
		return temporada;
	}

	public void setTemporada(Temporada temporada) {
		this.temporada = temporada;
	}
}