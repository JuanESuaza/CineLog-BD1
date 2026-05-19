package co.edu.unbosque.cinelog_backend.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "CONTENIDO")
public class Contenido {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_contenido")
	private Integer idContenido;

	@Column(name = "titulo", nullable = false)
	private String titulo;

	@Column(name = "tipo", nullable = false)
	private String tipo;

	@Column(name = "anio_estreno")
	private Short anioEstreno;

	@Column(name = "sinopsis", columnDefinition = "TEXT")
	private String sinopsis;

	@Column(name = "idioma")
	private String idioma;

	@Column(name = "url_portada", columnDefinition = "TEXT")
	private String urlPortada;

	@Column(name = "fecha_agregado", nullable = false)
	private LocalDate fechaAgregado;

	public Integer getIdContenido() {
		return idContenido;
	}

	public void setIdContenido(Integer idContenido) {
		this.idContenido = idContenido;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public Short getAnioEstreno() {
		return anioEstreno;
	}

	public void setAnioEstreno(Short anioEstreno) {
		this.anioEstreno = anioEstreno;
	}

	public String getSinopsis() {
		return sinopsis;
	}

	public void setSinopsis(String sinopsis) {
		this.sinopsis = sinopsis;
	}

	public String getIdioma() {
		return idioma;
	}

	public void setIdioma(String idioma) {
		this.idioma = idioma;
	}

	public String getUrlPortada() {
		return urlPortada;
	}

	public void setUrlPortada(String urlPortada) {
		this.urlPortada = urlPortada;
	}

	public LocalDate getFechaAgregado() {
		return fechaAgregado;
	}

	public void setFechaAgregado(LocalDate fechaAgregado) {
		this.fechaAgregado = fechaAgregado;
	}
}