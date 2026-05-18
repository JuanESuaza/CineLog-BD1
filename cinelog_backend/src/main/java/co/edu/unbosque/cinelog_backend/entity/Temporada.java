package co.edu.unbosque.cinelog_backend.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "TEMPORADA")
public class Temporada {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_temporada")
	private Integer idTemporada;

	@Column(name = "numero_temporada", nullable = false)
	private Short numeroTemporada;

	@Column(name = "anio_estreno")
	private Short anioEstreno;

	@ManyToOne
	@JoinColumn(name = "id_contenido", nullable = false)
	private Contenido contenido;

	public Integer getIdTemporada() {
		return idTemporada;
	}

	public void setIdTemporada(Integer idTemporada) {
		this.idTemporada = idTemporada;
	}

	public Short getNumeroTemporada() {
		return numeroTemporada;
	}

	public void setNumeroTemporada(Short numeroTemporada) {
		this.numeroTemporada = numeroTemporada;
	}

	public Short getAnioEstreno() {
		return anioEstreno;
	}

	public void setAnioEstreno(Short anioEstreno) {
		this.anioEstreno = anioEstreno;
	}

	public Contenido getContenido() {
		return contenido;
	}

	public void setContenido(Contenido contenido) {
		this.contenido = contenido;
	}
}