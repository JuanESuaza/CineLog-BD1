package co.edu.unbosque.cinelog_backend.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "GENERO")
public class Genero {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_genero")
	private Integer idGenero;

	@Column(name = "nombre", nullable = false, unique = true)
	private String nombre;

	public Integer getIdGenero() {
		return idGenero;
	}

	public void setIdGenero(Integer idGenero) {
		this.idGenero = idGenero;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
}