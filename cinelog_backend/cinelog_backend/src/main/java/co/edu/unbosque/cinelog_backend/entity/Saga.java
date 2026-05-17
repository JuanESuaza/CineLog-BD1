package co.edu.unbosque.cinelog_backend.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "SAGA")
public class Saga {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_saga")
	private Integer idSaga;

	@Column(name = "nombre", nullable = false)
	private String nombre;

	@Column(name = "descripcion", columnDefinition = "TEXT")
	private String descripcion;

	@ManyToOne
	@JoinColumn(name = "id_universo", nullable = false)
	private Universo universo;

	public Integer getIdSaga() {
		return idSaga;
	}

	public void setIdSaga(Integer idSaga) {
		this.idSaga = idSaga;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public Universo getUniverso() {
		return universo;
	}

	public void setUniverso(Universo universo) {
		this.universo = universo;
	}
}