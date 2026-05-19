package co.edu.unbosque.cinelog_backend.dto;

public class FinalAlternativoRequest {

    private Integer id_contenido;
    private String texto_final;

    private String textoFinal;
    private String texto;

    public FinalAlternativoRequest() {
    }

    public Integer getId_contenido() {
        return id_contenido;
    }

    public void setId_contenido(Integer id_contenido) {
        this.id_contenido = id_contenido;
    }

    public String getTexto_final() {
        if (texto_final != null && !texto_final.isBlank()) {
            return texto_final;
        }

        if (textoFinal != null && !textoFinal.isBlank()) {
            return textoFinal;
        }

        return texto;
    }

    public void setTexto_final(String texto_final) {
        this.texto_final = texto_final;
    }

    public String getTextoFinal() {
        return textoFinal;
    }

    public void setTextoFinal(String textoFinal) {
        this.textoFinal = textoFinal;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }
}