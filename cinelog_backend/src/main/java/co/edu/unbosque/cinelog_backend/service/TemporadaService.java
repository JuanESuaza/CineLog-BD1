package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.entity.Temporada;
import co.edu.unbosque.cinelog_backend.repository.TemporadaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TemporadaService {

	private final TemporadaRepository temporadaRepository;

	public TemporadaService(TemporadaRepository temporadaRepository) {
		this.temporadaRepository = temporadaRepository;
	}

	public List<Temporada> findAll() {
		return temporadaRepository.findAll();
	}

	public Temporada findById(Integer id) {
		return temporadaRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Temporada no encontrada con id: " + id));
	}

	public Temporada save(Temporada temporada) {
		return temporadaRepository.save(temporada);
	}

	public void deleteById(Integer id) {
		Temporada temporada = findById(id);
		temporadaRepository.delete(temporada);
	}
}