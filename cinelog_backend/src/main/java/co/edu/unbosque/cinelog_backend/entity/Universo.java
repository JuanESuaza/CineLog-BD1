package co.edu.unbosque.cinelog_backend.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "UNIVERSO")
public class Universo {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_universo")
	private Integer idUniverso;

	@Column(name = "nombre", nullable = false, unique = true)
	private String nombre;

	@Column(name = "descripcion", columnDefinition = "TEXT")
	private String descripcion;

	public Integer getIdUniverso() {
		return idUniverso;
	}

	public void setIdUniverso(Integer idUniverso) {
		this.idUniverso = idUniverso;
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
}