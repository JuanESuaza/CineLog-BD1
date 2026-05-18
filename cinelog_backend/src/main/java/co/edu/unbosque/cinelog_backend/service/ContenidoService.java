package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.entity.Contenido;
import co.edu.unbosque.cinelog_backend.repository.ContenidoRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class ContenidoService {

	private final ContenidoRepository contenidoRepository;

	@PersistenceContext
	private EntityManager entityManager;

	public ContenidoService(ContenidoRepository contenidoRepository) {
		this.contenidoRepository = contenidoRepository;
	}

	public List<Contenido> findAll() {
		return contenidoRepository.findAll();
	}

	public Contenido findById(Integer id) {
		return contenidoRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Contenido no encontrado con id: " + id));
	}

	public Contenido save(Contenido contenido) {
		return contenidoRepository.save(contenido);
	}

	public void deleteById(Integer id) {
		Contenido contenido = findById(id);
		contenidoRepository.delete(contenido);
	}

	public List<Map<String, Object>> obtenerCatalogoCompleto() {
		Query query = entityManager.createNativeQuery("""
				SELECT
				    id_contenido,
				    titulo,
				    tipo,
				    anio_estreno,
				    idioma,
				    url_portada,
				    puntuacion_promedio,
				    total_calificaciones
				FROM V_CATALOGO_COMPLETO
				ORDER BY titulo
				""");

		List<?> filas = query.getResultList();
		List<Map<String, Object>> respuesta = new ArrayList<>();

		for (Object fila : filas) {
			Object[] c = (Object[]) fila;

			Map<String, Object> item = new LinkedHashMap<>();
			item.put("id_contenido", c[0]);
			item.put("titulo", c[1]);
			item.put("tipo", c[2]);
			item.put("anio_estreno", c[3]);
			item.put("idioma", c[4]);
			item.put("url_portada", c[5]);
			item.put("puntuacion_promedio", c[6]);
			item.put("total_calificaciones", c[7]);

			respuesta.add(item);
		}

		return respuesta;
	}

	public Map<String, Object> obtenerDetalleContenido(Integer idContenido) {
		Query query = entityManager.createNativeQuery("""
				SELECT
				    c.id_contenido,
				    c.titulo,
				    c.tipo,
				    c.anio_estreno,
				    c.sinopsis,
				    c.idioma,
				    c.url_portada,
				    c.fecha_agregado
				FROM CONTENIDO c
				WHERE c.id_contenido = ?
				""");

		query.setParameter(1, idContenido);

		List<?> filas = query.getResultList();

		if (filas.isEmpty()) {
			throw new RuntimeException("Contenido no encontrado");
		}

		Object[] c = (Object[]) filas.get(0);

		Map<String, Object> item = new LinkedHashMap<>();
		item.put("id_contenido", c[0]);
		item.put("titulo", c[1]);
		item.put("tipo", c[2]);
		item.put("anio_estreno", c[3]);
		item.put("sinopsis", c[4]);
		item.put("idioma", c[5]);
		item.put("url_portada", c[6]);
		item.put("fecha_agregado", c[7]);

		return item;
	}

	public List<Map<String, Object>> obtenerTop10() {
		Query query = entityManager.createNativeQuery("""
				SELECT
				    id_contenido,
				    titulo,
				    tipo,
				    anio_estreno,
				    idioma,
				    url_portada,
				    puntuacion_promedio,
				    total_calificaciones
				FROM V_CATALOGO_COMPLETO
				ORDER BY puntuacion_promedio DESC, total_calificaciones DESC
				LIMIT 10
				""");

		List<?> filas = query.getResultList();
		List<Map<String, Object>> respuesta = new ArrayList<>();

		for (Object fila : filas) {
			Object[] c = (Object[]) fila;

			Map<String, Object> item = new LinkedHashMap<>();
			item.put("id_contenido", c[0]);
			item.put("titulo", c[1]);
			item.put("tipo", c[2]);
			item.put("anio_estreno", c[3]);
			item.put("idioma", c[4]);
			item.put("url_portada", c[5]);
			item.put("puntuacion_promedio", c[6]);
			item.put("total_calificaciones", c[7]);

			respuesta.add(item);
		}

		return respuesta;
	}

	public List<Map<String, Object>> obtenerPorGenero(Integer idGenero) {
		Query query = entityManager.createNativeQuery("""
				SELECT
				    c.id_contenido,
				    c.titulo,
				    c.tipo,
				    c.anio_estreno,
				    c.idioma,
				    c.url_portada,
				    g.id_genero,
				    g.nombre AS genero
				FROM CONTENIDO c
				INNER JOIN CONTENIDO_GENERO cg ON c.id_contenido = cg.id_contenido
				INNER JOIN GENERO g ON cg.id_genero = g.id_genero
				WHERE cg.id_genero = ?
				ORDER BY c.titulo
				""");

		query.setParameter(1, idGenero);

		List<?> filas = query.getResultList();
		List<Map<String, Object>> respuesta = new ArrayList<>();

		for (Object fila : filas) {
			Object[] c = (Object[]) fila;

			Map<String, Object> item = new LinkedHashMap<>();
			item.put("id_contenido", c[0]);
			item.put("titulo", c[1]);
			item.put("tipo", c[2]);
			item.put("anio_estreno", c[3]);
			item.put("idioma", c[4]);
			item.put("url_portada", c[5]);
			item.put("id_genero", c[6]);
			item.put("genero", c[7]);

			respuesta.add(item);
		}

		return respuesta;
	}

	public List<Map<String, Object>> obtenerPorGeneroAleatorio() {
		Query query = entityManager.createNativeQuery("""
				SELECT
				    c.id_contenido,
				    c.titulo,
				    c.tipo,
				    c.anio_estreno,
				    c.idioma,
				    c.url_portada,
				    g.id_genero,
				    g.nombre AS genero
				FROM CONTENIDO c
				INNER JOIN CONTENIDO_GENERO cg ON c.id_contenido = cg.id_contenido
				INNER JOIN GENERO g ON cg.id_genero = g.id_genero
				WHERE g.id_genero = (
				    SELECT id_genero
				    FROM GENERO
				    ORDER BY id_genero
				    LIMIT 1
				)
				ORDER BY c.titulo
				""");

		List<?> filas = query.getResultList();
		List<Map<String, Object>> respuesta = new ArrayList<>();

		for (Object fila : filas) {
			Object[] c = (Object[]) fila;

			Map<String, Object> item = new LinkedHashMap<>();
			item.put("id_contenido", c[0]);
			item.put("titulo", c[1]);
			item.put("tipo", c[2]);
			item.put("anio_estreno", c[3]);
			item.put("idioma", c[4]);
			item.put("url_portada", c[5]);
			item.put("id_genero", c[6]);
			item.put("genero", c[7]);

			respuesta.add(item);
		}

		return respuesta;
	}

	public List<Map<String, Object>> obtenerCatalogoFiltrado(String tipo, String genero, String busqueda) {

		StringBuilder sql = new StringBuilder("""
				SELECT
				    c.id_contenido,
				    c.titulo,
				    c.tipo,
				    c.anio_estreno,
				    c.idioma,
				    c.url_portada,
				    ROUND(AVG(cal.puntuacion), 1) AS puntuacion_promedio,
				    COUNT(DISTINCT cal.id_usuario) AS total_calificaciones
				FROM CONTENIDO c
				LEFT JOIN CALIFICACION cal ON c.id_contenido = cal.id_contenido
				LEFT JOIN CONTENIDO_GENERO cg ON c.id_contenido = cg.id_contenido
				LEFT JOIN GENERO g ON cg.id_genero = g.id_genero
				WHERE 1 = 1
				""");

		List<Object> parametros = new ArrayList<>();

		if (tipo != null && !tipo.isBlank()) {
			String tipoNormalizado = tipo.trim().toLowerCase();

			if (tipoNormalizado.contains("pel")) {
				sql.append(" AND c.tipo = ? ");
				parametros.add("Película");
			} else if (tipoNormalizado.contains("serie")) {
				sql.append(" AND c.tipo = ? ");
				parametros.add("Serie");
			}
		}

		if (genero != null && !genero.isBlank()) {
			sql.append(" AND g.nombre = ? ");
			parametros.add(genero.trim());
		}

		if (busqueda != null && !busqueda.isBlank()) {
			sql.append(" AND c.titulo LIKE ? ");
			parametros.add("%" + busqueda.trim() + "%");
		}

		sql.append("""
				GROUP BY
				    c.id_contenido,
				    c.titulo,
				    c.tipo,
				    c.anio_estreno,
				    c.idioma,
				    c.url_portada
				ORDER BY puntuacion_promedio DESC, c.anio_estreno DESC
				""");

		Query query = entityManager.createNativeQuery(sql.toString());

		for (int i = 0; i < parametros.size(); i++) {
			query.setParameter(i + 1, parametros.get(i));
		}

		List<?> filas = query.getResultList();
		List<Map<String, Object>> respuesta = new ArrayList<>();

		for (Object fila : filas) {
			Object[] c = (Object[]) fila;

			Map<String, Object> item = new LinkedHashMap<>();
			item.put("id_contenido", c[0]);
			item.put("titulo", c[1]);
			item.put("tipo", c[2]);
			item.put("anio_estreno", c[3]);
			item.put("idioma", c[4]);
			item.put("url_portada", c[5]);
			item.put("puntuacion_promedio", c[6]);
			item.put("total_calificaciones", c[7]);

			respuesta.add(item);
		}

		return respuesta;
	}
}