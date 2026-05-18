package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.dto.AgregarContenidoListaRequest;
import co.edu.unbosque.cinelog_backend.dto.ListaRequest;
import co.edu.unbosque.cinelog_backend.dto.MoverContenidoRequest;
import co.edu.unbosque.cinelog_backend.entity.Lista;
import co.edu.unbosque.cinelog_backend.repository.ListaRepository;
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
public class ListaService {

	private final ListaRepository listaRepository;
	private final JwtUtil jwtUtil;

	@PersistenceContext
	private EntityManager entityManager;

	public ListaService(ListaRepository listaRepository, JwtUtil jwtUtil) {
		this.listaRepository = listaRepository;
		this.jwtUtil = jwtUtil;
	}

	public List<Lista> findAll() {
		return listaRepository.findAll();
	}

	public Lista findById(Integer id) {
		return listaRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Lista no encontrada con id: " + id));
	}

	public Lista save(Lista lista) {
		return listaRepository.save(lista);
	}

	public void deleteById(Integer id) {
		Lista lista = findById(id);
		listaRepository.delete(lista);
	}

	public List<Map<String, Object>> obtenerListasDelUsuario(String authorizationHeader) {
		Integer idUsuario = obtenerIdUsuario(authorizationHeader);

		Query query = entityManager.createNativeQuery("""
				SELECT
				    l.id_lista,
				    l.nombre,
				    l.descripcion,
				    l.fecha_creacion,
				    COUNT(lc.id_contenido) AS total_contenidos
				FROM LISTA l
				LEFT JOIN LISTACONTENIDO lc ON l.id_lista = lc.id_lista
				WHERE l.id_usuario = ?
				GROUP BY l.id_lista, l.nombre, l.descripcion, l.fecha_creacion
				ORDER BY l.fecha_creacion DESC, l.id_lista DESC
				""");

		query.setParameter(1, idUsuario);

		List<?> filas = query.getResultList();
		List<Map<String, Object>> respuesta = new ArrayList<>();

		for (Object fila : filas) {
			Object[] c = (Object[]) fila;

			Integer idLista = ((Number) c[0]).intValue();

			Map<String, Object> item = new LinkedHashMap<>();
			item.put("id_lista", idLista);
			item.put("nombre", c[1]);
			item.put("descripcion", c[2]);
			item.put("fecha_creacion", c[3]);
			item.put("total_contenidos", c[4]);

			List<Map<String, Object>> contenidos = obtenerContenidosDeListaSinValidar(idLista);

			item.put("contenidos", contenidos);
			item.put("peliculas", contenidos);

			respuesta.add(item);
		}

		return respuesta;
	}

	public List<Map<String, Object>> obtenerContenidosDeLista(String authorizationHeader, Integer idLista) {
		Integer idUsuario = obtenerIdUsuario(authorizationHeader);
		validarListaDelUsuario(idLista, idUsuario);

		Query query = entityManager.createNativeQuery("""
				SELECT
				    lc.id_lista,
				    lc.id_contenido,
				    lc.posicion,
				    c.titulo,
				    c.tipo,
				    c.anio_estreno,
				    c.idioma,
				    c.url_portada
				FROM LISTACONTENIDO lc
				INNER JOIN CONTENIDO c ON lc.id_contenido = c.id_contenido
				WHERE lc.id_lista = ?
				ORDER BY lc.posicion ASC
				""");

		query.setParameter(1, idLista);

		List<?> filas = query.getResultList();
		List<Map<String, Object>> respuesta = new ArrayList<>();

		for (Object fila : filas) {
			Object[] c = (Object[]) fila;

			Map<String, Object> item = new LinkedHashMap<>();
			item.put("id_lista", c[0]);
			item.put("id_contenido", c[1]);
			item.put("posicion", c[2]);
			item.put("titulo", c[3]);
			item.put("tipo", c[4]);
			item.put("anio_estreno", c[5]);
			item.put("idioma", c[6]);
			item.put("url_portada", c[7]);

			respuesta.add(item);
		}

		return respuesta;
	}

	@Transactional
	public Map<String, Object> crearLista(String authorizationHeader, ListaRequest request) {
		Integer idUsuario = obtenerIdUsuario(authorizationHeader);

		if (request.getNombre() == null || request.getNombre().trim().isEmpty()) {
			throw new RuntimeException("El nombre de la lista es obligatorio");
		}

		Query insert = entityManager.createNativeQuery("""
				INSERT INTO LISTA (
				    nombre,
				    descripcion,
				    fecha_creacion,
				    id_usuario
				)
				VALUES (?, ?, ?, ?)
				""");

		insert.setParameter(1, request.getNombre());
		insert.setParameter(2, request.getDescripcion());
		insert.setParameter(3, LocalDate.now());
		insert.setParameter(4, idUsuario);

		insert.executeUpdate();

		Query idQuery = entityManager.createNativeQuery("SELECT LAST_INSERT_ID()");
		Number idGenerado = (Number) idQuery.getSingleResult();

		Map<String, Object> respuesta = new LinkedHashMap<>();
		respuesta.put("message", "Lista creada correctamente");
		respuesta.put("id_lista", idGenerado.intValue());
		respuesta.put("nombre", request.getNombre());
		respuesta.put("descripcion", request.getDescripcion());
		respuesta.put("id_usuario", idUsuario);

		return respuesta;
	}

	@Transactional
	public Map<String, Object> agregarContenidoALista(String authorizationHeader, Integer idLista,
			AgregarContenidoListaRequest request) {
		Integer idUsuario = obtenerIdUsuario(authorizationHeader);
		validarListaDelUsuario(idLista, idUsuario);

		if (request.getId_contenido() == null) {
			throw new RuntimeException("El id_contenido es obligatorio");
		}

		validarContenidoExiste(request.getId_contenido());

		if (contenidoYaEstaEnLista(idLista, request.getId_contenido())) {
			throw new RuntimeException("El contenido ya esta en la lista");
		}

		Integer nuevaPosicion = obtenerSiguientePosicion(idLista);

		Query insert = entityManager.createNativeQuery("""
				INSERT INTO LISTACONTENIDO (
				    id_lista,
				    id_contenido,
				    posicion
				)
				VALUES (?, ?, ?)
				""");

		insert.setParameter(1, idLista);
		insert.setParameter(2, request.getId_contenido());
		insert.setParameter(3, nuevaPosicion);

		insert.executeUpdate();

		Map<String, Object> respuesta = new LinkedHashMap<>();
		respuesta.put("message", "Contenido agregado a la lista correctamente");
		respuesta.put("id_lista", idLista);
		respuesta.put("id_contenido", request.getId_contenido());
		respuesta.put("posicion", nuevaPosicion);

		return respuesta;
	}

	@Transactional
	public Map<String, Object> eliminarContenidoDeLista(String authorizationHeader, Integer idLista,
			Integer idContenido) {
		Integer idUsuario = obtenerIdUsuario(authorizationHeader);
		validarListaDelUsuario(idLista, idUsuario);

		Query delete = entityManager.createNativeQuery("""
				DELETE FROM LISTACONTENIDO
				WHERE id_lista = ?
				AND id_contenido = ?
				""");

		delete.setParameter(1, idLista);
		delete.setParameter(2, idContenido);

		int filasAfectadas = delete.executeUpdate();

		if (filasAfectadas == 0) {
			throw new RuntimeException("El contenido no estaba en la lista");
		}

		reordenarPosiciones(idLista);

		Map<String, Object> respuesta = new LinkedHashMap<>();
		respuesta.put("message", "Contenido eliminado de la lista correctamente");
		respuesta.put("id_lista", idLista);
		respuesta.put("id_contenido", idContenido);

		return respuesta;
	}

	@Transactional
	public Map<String, Object> eliminarLista(String authorizationHeader, Integer idLista) {
		Integer idUsuario = obtenerIdUsuario(authorizationHeader);
		validarListaDelUsuario(idLista, idUsuario);

		Query deleteContenidos = entityManager.createNativeQuery("""
				DELETE FROM LISTACONTENIDO
				WHERE id_lista = ?
				""");

		deleteContenidos.setParameter(1, idLista);
		deleteContenidos.executeUpdate();

		Query deleteLista = entityManager.createNativeQuery("""
				DELETE FROM LISTA
				WHERE id_lista = ?
				AND id_usuario = ?
				""");

		deleteLista.setParameter(1, idLista);
		deleteLista.setParameter(2, idUsuario);

		deleteLista.executeUpdate();

		Map<String, Object> respuesta = new LinkedHashMap<>();
		respuesta.put("message", "Lista eliminada correctamente");
		respuesta.put("id_lista", idLista);

		return respuesta;
	}

	@Transactional
	public Map<String, Object> moverContenido(String authorizationHeader, Integer idLista, Integer idContenido,
			MoverContenidoRequest request) {
		Integer idUsuario = obtenerIdUsuario(authorizationHeader);
		validarListaDelUsuario(idLista, idUsuario);

		if (request.getDireccion() == null || request.getDireccion().trim().isEmpty()) {
			throw new RuntimeException("La direccion es obligatoria");
		}

		String direccion = request.getDireccion().trim().toLowerCase();

		if (!direccion.equals("arriba") && !direccion.equals("abajo")) {
			throw new RuntimeException("La direccion debe ser 'arriba' o 'abajo'");
		}

		Integer posicionActual = obtenerPosicionActual(idLista, idContenido);

		Integer posicionDestino;

		if (direccion.equals("arriba")) {
			posicionDestino = posicionActual - 1;
		} else {
			posicionDestino = posicionActual + 1;
		}

		Integer idContenidoDestino = obtenerContenidoPorPosicion(idLista, posicionDestino);

		if (idContenidoDestino == null) {
			throw new RuntimeException("No se puede mover el contenido mas " + direccion);
		}

		Query updateDestino = entityManager.createNativeQuery("""
				UPDATE LISTACONTENIDO
				SET posicion = ?
				WHERE id_lista = ?
				AND id_contenido = ?
				""");

		updateDestino.setParameter(1, posicionActual);
		updateDestino.setParameter(2, idLista);
		updateDestino.setParameter(3, idContenidoDestino);
		updateDestino.executeUpdate();

		Query updateActual = entityManager.createNativeQuery("""
				UPDATE LISTACONTENIDO
				SET posicion = ?
				WHERE id_lista = ?
				AND id_contenido = ?
				""");

		updateActual.setParameter(1, posicionDestino);
		updateActual.setParameter(2, idLista);
		updateActual.setParameter(3, idContenido);
		updateActual.executeUpdate();

		Map<String, Object> respuesta = new LinkedHashMap<>();
		respuesta.put("message", "Contenido movido correctamente");
		respuesta.put("id_lista", idLista);
		respuesta.put("id_contenido", idContenido);
		respuesta.put("direccion", direccion);
		respuesta.put("posicion_anterior", posicionActual);
		respuesta.put("posicion_nueva", posicionDestino);

		return respuesta;
	}

	private Integer obtenerIdUsuario(String authorizationHeader) {
		String token = jwtUtil.extractTokenFromHeader(authorizationHeader);
		return jwtUtil.getIdUsuarioFromToken(token);
	}

	private void validarListaDelUsuario(Integer idLista, Integer idUsuario) {
		Query query = entityManager.createNativeQuery("""
				SELECT COUNT(*)
				FROM LISTA
				WHERE id_lista = ?
				AND id_usuario = ?
				""");

		query.setParameter(1, idLista);
		query.setParameter(2, idUsuario);

		Number total = (Number) query.getSingleResult();

		if (total.intValue() == 0) {
			throw new RuntimeException("Lista no encontrada o no pertenece al usuario");
		}
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

	private boolean contenidoYaEstaEnLista(Integer idLista, Integer idContenido) {
		Query query = entityManager.createNativeQuery("""
				SELECT COUNT(*)
				FROM LISTACONTENIDO
				WHERE id_lista = ?
				AND id_contenido = ?
				""");

		query.setParameter(1, idLista);
		query.setParameter(2, idContenido);

		Number total = (Number) query.getSingleResult();

		return total.intValue() > 0;
	}

	private Integer obtenerSiguientePosicion(Integer idLista) {
		Query query = entityManager.createNativeQuery("""
				SELECT COALESCE(MAX(posicion), 0) + 1
				FROM LISTACONTENIDO
				WHERE id_lista = ?
				""");

		query.setParameter(1, idLista);

		Number posicion = (Number) query.getSingleResult();

		return posicion.intValue();
	}

	private Integer obtenerPosicionActual(Integer idLista, Integer idContenido) {
		Query query = entityManager.createNativeQuery("""
				SELECT posicion
				FROM LISTACONTENIDO
				WHERE id_lista = ?
				AND id_contenido = ?
				""");

		query.setParameter(1, idLista);
		query.setParameter(2, idContenido);

		List<?> resultado = query.getResultList();

		if (resultado.isEmpty()) {
			throw new RuntimeException("El contenido no esta en la lista");
		}

		Number posicion = (Number) resultado.get(0);

		return posicion.intValue();
	}

	private Integer obtenerContenidoPorPosicion(Integer idLista, Integer posicion) {
		Query query = entityManager.createNativeQuery("""
				SELECT id_contenido
				FROM LISTACONTENIDO
				WHERE id_lista = ?
				AND posicion = ?
				""");

		query.setParameter(1, idLista);
		query.setParameter(2, posicion);

		List<?> resultado = query.getResultList();

		if (resultado.isEmpty()) {
			return null;
		}

		Number idContenido = (Number) resultado.get(0);

		return idContenido.intValue();
	}

	private void reordenarPosiciones(Integer idLista) {
		Query query = entityManager.createNativeQuery("""
				SELECT id_contenido
				FROM LISTACONTENIDO
				WHERE id_lista = ?
				ORDER BY posicion ASC
				""");

		query.setParameter(1, idLista);

		List<?> contenidos = query.getResultList();

		int posicion = 1;

		for (Object item : contenidos) {
			Number idContenido = (Number) item;

			Query update = entityManager.createNativeQuery("""
					UPDATE LISTACONTENIDO
					SET posicion = ?
					WHERE id_lista = ?
					AND id_contenido = ?
					""");

			update.setParameter(1, posicion);
			update.setParameter(2, idLista);
			update.setParameter(3, idContenido.intValue());

			update.executeUpdate();

			posicion++;
		}
	}

	private List<Map<String, Object>> obtenerContenidosDeListaSinValidar(Integer idLista) {
		Query query = entityManager.createNativeQuery("""
				SELECT
				    lc.id_lista,
				    lc.id_contenido,
				    lc.posicion,
				    c.titulo,
				    c.tipo,
				    c.anio_estreno,
				    c.idioma,
				    c.url_portada
				FROM LISTACONTENIDO lc
				INNER JOIN CONTENIDO c ON lc.id_contenido = c.id_contenido
				WHERE lc.id_lista = ?
				ORDER BY lc.posicion ASC
				""");

		query.setParameter(1, idLista);

		List<?> filas = query.getResultList();
		List<Map<String, Object>> respuesta = new ArrayList<>();

		for (Object fila : filas) {
			Object[] c = (Object[]) fila;

			Map<String, Object> item = new LinkedHashMap<>();
			item.put("id_lista", c[0]);
			item.put("id_contenido", c[1]);
			item.put("id", c[1]);
			item.put("posicion", c[2]);
			item.put("titulo", c[3]);
			item.put("nombre", c[3]);
			item.put("tipo", c[4]);
			item.put("anio_estreno", c[5]);
			item.put("anio", c[5]);
			item.put("idioma", c[6]);
			item.put("url_portada", c[7]);
			item.put("poster", c[7]);
			item.put("imagen", c[7]);

			respuesta.add(item);
		}

		return respuesta;
	}

}