package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.dto.CalificacionRequest;
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
public class CalificacionService {

	@PersistenceContext
	private EntityManager entityManager;

	private final JwtUtil jwtUtil;

	public CalificacionService(JwtUtil jwtUtil) {
		this.jwtUtil = jwtUtil;
	}

	public List<Map<String, Object>> obtenerCalificacionesPorContenido(Integer idContenido) {

		Query query = entityManager.createNativeQuery("""
				SELECT
				    u.nombre_usuario,
				    c.titulo,
				    cal.puntuacion,
				    cal.resenia,
				    cal.fecha_calificacion
				FROM CALIFICACION cal
				INNER JOIN USUARIO u ON cal.id_usuario = u.id_usuario
				INNER JOIN CONTENIDO c ON cal.id_contenido = c.id_contenido
				WHERE cal.id_contenido = ?
				ORDER BY cal.fecha_calificacion DESC
				""");

		query.setParameter(1, idContenido);

		List<?> filas = query.getResultList();
		List<Map<String, Object>> respuesta = new ArrayList<>();

		for (Object fila : filas) {
			Object[] c = (Object[]) fila;

			Map<String, Object> item = new LinkedHashMap<>();
			item.put("nombre_usuario", c[0]);
			item.put("titulo", c[1]);
			item.put("puntuacion", c[2]);
			item.put("resenia", c[3]);
			item.put("fecha_calificacion", c[4]);

			respuesta.add(item);
		}

		return respuesta;
	}

	@Transactional
	public Map<String, Object> guardarCalificacion(String authorizationHeader, CalificacionRequest request) {

		String token = jwtUtil.extractTokenFromHeader(authorizationHeader);
		Integer idUsuario = jwtUtil.getIdUsuarioFromToken(token);

		if (request.getId_contenido() == null) {
			throw new RuntimeException("El id_contenido es obligatorio");
		}

		if (request.getPuntuacion() == null) {
			throw new RuntimeException("La puntuación es obligatoria");
		}

		if (request.getPuntuacion() < 1 || request.getPuntuacion() > 5) {
			throw new RuntimeException("La puntuación debe estar entre 1 y 5");
		}

		Query query = entityManager.createNativeQuery("""
				INSERT INTO CALIFICACION (
				    id_usuario,
				    id_contenido,
				    puntuacion,
				    resenia,
				    fecha_calificacion
				)
				VALUES (?, ?, ?, ?, ?)
				ON DUPLICATE KEY UPDATE
				    puntuacion = VALUES(puntuacion),
				    resenia = VALUES(resenia),
				    fecha_calificacion = VALUES(fecha_calificacion)
				""");

		query.setParameter(1, idUsuario);
		query.setParameter(2, request.getId_contenido());
		query.setParameter(3, request.getPuntuacion());
		query.setParameter(4, request.getResenia());
		query.setParameter(5, LocalDate.now());

		query.executeUpdate();

		Map<String, Object> respuesta = new LinkedHashMap<>();
		respuesta.put("message", "Calificación guardada correctamente");
		respuesta.put("id_usuario", idUsuario);
		respuesta.put("id_contenido", request.getId_contenido());
		respuesta.put("puntuacion", request.getPuntuacion());
		respuesta.put("resenia", request.getResenia());

		return respuesta;
	}
}