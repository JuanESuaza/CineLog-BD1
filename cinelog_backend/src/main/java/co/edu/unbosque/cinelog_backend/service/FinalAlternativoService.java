package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.dto.FinalAlternativoRequest;
import co.edu.unbosque.cinelog_backend.security.JwtUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class FinalAlternativoService {

    @PersistenceContext
    private EntityManager entityManager;

    private final JwtUtil jwtUtil;

    public FinalAlternativoService(JwtUtil jwtUtil) {
        this.jwtUtil = jwtUtil;
    }

    public Map<String, Object> obtenerFinalDelUsuario(
            String authorizationHeader,
            Integer idContenido
    ) {
        Integer idUsuario = obtenerIdUsuario(authorizationHeader);

        Query query = entityManager.createNativeQuery("""
                SELECT
                    fa.id_usuario,
                    u.nombre_usuario,
                    fa.id_contenido,
                    c.titulo,
                    fa.texto_final,
                    fa.fecha_escritura
                FROM FINALALTERNATIVO fa
                INNER JOIN USUARIO u ON fa.id_usuario = u.id_usuario
                INNER JOIN CONTENIDO c ON fa.id_contenido = c.id_contenido
                WHERE fa.id_usuario = ?
                AND fa.id_contenido = ?
                """);

        query.setParameter(1, idUsuario);
        query.setParameter(2, idContenido);

        List<?> filas = query.getResultList();

        if (filas.isEmpty()) {
            Map<String, Object> respuesta = new LinkedHashMap<>();
            respuesta.put("message", "No tienes un final alternativo para este contenido");
            respuesta.put("id_contenido", idContenido);
            return respuesta;
        }

        Object[] c = (Object[]) filas.get(0);

        Map<String, Object> item = new LinkedHashMap<>();
        item.put("id_usuario", c[0]);
        item.put("nombre_usuario", c[1]);
        item.put("id_contenido", c[2]);
        item.put("titulo", c[3]);
        item.put("texto_final", c[4]);
        item.put("fecha_escritura", c[5]);

        return item;
    }

    public List<Map<String, Object>> obtenerTodosLosFinales(Integer idContenido) {
        Query query = entityManager.createNativeQuery("""
                SELECT
                    fa.id_usuario,
                    u.nombre_usuario,
                    fa.id_contenido,
                    c.titulo,
                    fa.texto_final,
                    fa.fecha_escritura
                FROM FINALALTERNATIVO fa
                INNER JOIN USUARIO u ON fa.id_usuario = u.id_usuario
                INNER JOIN CONTENIDO c ON fa.id_contenido = c.id_contenido
                WHERE fa.id_contenido = ?
                ORDER BY fa.fecha_escritura DESC
                """);

        query.setParameter(1, idContenido);

        List<?> filas = query.getResultList();
        List<Map<String, Object>> respuesta = new ArrayList<>();

        for (Object fila : filas) {
            Object[] c = (Object[]) fila;

            Map<String, Object> item = new LinkedHashMap<>();
            item.put("id_usuario", c[0]);
            item.put("nombre_usuario", c[1]);
            item.put("id_contenido", c[2]);
            item.put("titulo", c[3]);
            item.put("texto_final", c[4]);
            item.put("fecha_escritura", c[5]);

            respuesta.add(item);
        }

        return respuesta;
    }

    public List<Map<String, Object>> obtenerMisFinales(String authorizationHeader) {
        Integer idUsuario = obtenerIdUsuario(authorizationHeader);

        Query query = entityManager.createNativeQuery("""
                SELECT
                    fa.id_usuario,
                    fa.id_contenido,
                    c.titulo,
                    c.tipo,
                    c.url_portada,
                    fa.texto_final,
                    fa.fecha_escritura
                FROM FINALALTERNATIVO fa
                INNER JOIN CONTENIDO c ON fa.id_contenido = c.id_contenido
                WHERE fa.id_usuario = ?
                ORDER BY fa.fecha_escritura DESC
                """);

        query.setParameter(1, idUsuario);

        List<?> filas = query.getResultList();
        List<Map<String, Object>> respuesta = new ArrayList<>();

        for (Object fila : filas) {
            Object[] c = (Object[]) fila;

            Map<String, Object> item = new LinkedHashMap<>();
            item.put("id_usuario", c[0]);
            item.put("id_contenido", c[1]);
            item.put("titulo", c[2]);
            item.put("tipo", c[3]);
            item.put("url_portada", c[4]);
            item.put("texto_final", c[5]);
            item.put("fecha_escritura", c[6]);

            respuesta.add(item);
        }

        return respuesta;
    }

    @Transactional
    public Map<String, Object> guardarFinal(
            String authorizationHeader,
            FinalAlternativoRequest request
    ) {
        Integer idUsuario = obtenerIdUsuario(authorizationHeader);

        if (request.getId_contenido() == null) {
            throw new RuntimeException("El id_contenido es obligatorio");
        }

        if (request.getTexto_final() == null || request.getTexto_final().trim().isEmpty()) {
            throw new RuntimeException("El texto_final es obligatorio");
        }

        validarContenidoExiste(request.getId_contenido());

        Query query = entityManager.createNativeQuery("""
                INSERT INTO FINALALTERNATIVO (
                    id_usuario,
                    id_contenido,
                    texto_final,
                    fecha_escritura
                )
                VALUES (?, ?, ?, ?)
                ON DUPLICATE KEY UPDATE
                    texto_final = VALUES(texto_final),
                    fecha_escritura = VALUES(fecha_escritura)
                """);

        query.setParameter(1, idUsuario);
        query.setParameter(2, request.getId_contenido());
        query.setParameter(3, request.getTexto_final());
        query.setParameter(4, LocalDate.now());

        query.executeUpdate();

        Map<String, Object> respuesta = new LinkedHashMap<>();
        respuesta.put("message", "Final alternativo guardado correctamente");
        respuesta.put("id_usuario", idUsuario);
        respuesta.put("id_contenido", request.getId_contenido());
        respuesta.put("texto_final", request.getTexto_final());

        return respuesta;
    }

    private Integer obtenerIdUsuario(String authorizationHeader) {
        String token = jwtUtil.extractTokenFromHeader(authorizationHeader);
        return jwtUtil.getIdUsuarioFromToken(token);
    }

    private void validarContenidoExiste(Integer idContenido) {
        Query query = entityManager.createNativeQuery("""
                SELECT COUNT(*)
                FROM CONTENIDO
                WHERE id_contenido = ?
                """);

        query.setParameter(1, idContenido);

        Number total = (Number) query.getSingleResult();

        if (total.intValue() == 0) {
            throw new RuntimeException("Contenido no encontrado");
        }
    }
}