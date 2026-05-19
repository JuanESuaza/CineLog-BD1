package co.edu.unbosque.cinelog_backend.dto;

public class ListaRequest {

	private String nombre;
	private String descripcion;

	public ListaRequest() {
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