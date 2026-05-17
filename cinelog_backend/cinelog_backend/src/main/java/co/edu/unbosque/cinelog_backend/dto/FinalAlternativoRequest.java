package co.edu.unbosque.cinelog_backend.dto;

public class FinalAlternativoRequest {

	private Integer id_contenido;
	private String texto_final;

	public FinalAlternativoRequest() {
	}

	public Integer getId_contenido() {
		return id_contenido;
	}

	public void setId_contenido(Integer id_contenido) {
		this.id_contenido = id_contenido;
	}

	public String getTexto_final() {
		return texto_final;
	}

	public void setTexto_final(String texto_final) {
		this.texto_final = texto_final;
	}
}