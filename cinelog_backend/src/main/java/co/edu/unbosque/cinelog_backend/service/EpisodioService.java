package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.entity.Episodio;
import co.edu.unbosque.cinelog_backend.repository.EpisodioRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class EpisodioService {

	private final EpisodioRepository episodioRepository;

	@PersistenceContext
	private EntityManager entityManager;

	public EpisodioService(EpisodioRepository episodioRepository) {
		this.episodioRepository = episodioRepository;
	}

	public List<Episodio> findAll() {
		return episodioRepository.findAll();
	}

	public Episodio findById(Integer id) {
		return episodioRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Episodio no encontrado con id: " + id));
	}

	public Episodio save(Episodio episodio) {
		return episodioRepository.save(episodio);
	}

	public void deleteById(Integer id) {
		Episodio episodio = findById(id);
		episodioRepository.delete(episodio);
	}

	public List<Map<String, Object>> obtenerEpisodiosPorTemporada(Integer idTemporada) {
		Query query = entityManager.createNativeQuery("""
				SELECT
				    id_episodio,
				    numero_episodio,
				    titulo,
				    duracion_minutos,
				    fecha_emision,
				    id_temporada
				FROM EPISODIO
				WHERE id_temporada = ?
				ORDER BY numero_episodio
				""");

		query.setParameter(1, idTemporada);

		List<?> filas = query.getResultList();
		List<Map<String, Object>> respuesta = new ArrayList<>();

		for (Object fila : filas) {
			Object[] c = (Object[]) fila;

			Map<String, Object> item = new LinkedHashMap<>();
			item.put("id_episodio", c[0]);
			item.put("numero_episodio", c[1]);
			item.put("titulo", c[2]);
			item.put("duracion_minutos", c[3]);
			item.put("fecha_emision", c[4]);
			item.put("id_temporada", c[5]);

			respuesta.add(item);
		}

		return respuesta;
	}
}