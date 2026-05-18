package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.entity.Serie;
import co.edu.unbosque.cinelog_backend.repository.SerieRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SerieService {

	private final SerieRepository serieRepository;

	public SerieService(SerieRepository serieRepository) {
		this.serieRepository = serieRepository;
	}

	public List<Serie> findAll() {
		return serieRepository.findAll();
	}

	public Serie findById(Integer id) {
		return serieRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Serie no encontrada con id: " + id));
	}

	public Serie save(Serie serie) {
		return serieRepository.save(serie);
	}

	public void deleteById(Integer id) {
		Serie serie = findById(id);
		serieRepository.delete(serie);
	}
}