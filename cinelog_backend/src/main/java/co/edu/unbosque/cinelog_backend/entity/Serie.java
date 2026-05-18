package co.edu.unbosque.cinelog_backend.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "SERIE")
public class Serie {

	@Id
	@Column(name = "id_contenido")
	private Integer idContenido;

	@OneToOne
	@MapsId
	@JoinColumn(name = "id_contenido")
	private Contenido contenido;

	@Column(name = "en_emision", nullable = false)
	private Boolean enEmision;

	@Column(name = "num_temporadas", nullable = false)
	private Short numTemporadas;

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

	public Boolean getEnEmision() {
		return enEmision;
	}

	public void setEnEmision(Boolean enEmision) {
		this.enEmision = enEmision;
	}

	public Short getNumTemporadas() {
		return numTemporadas;
	}

	public void setNumTemporadas(Short numTemporadas) {
		this.numTemporadas = numTemporadas;
	}
}