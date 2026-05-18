package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.entity.Pelicula;
import co.edu.unbosque.cinelog_backend.repository.PeliculaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PeliculaService {

	private final PeliculaRepository peliculaRepository;

	public PeliculaService(PeliculaRepository peliculaRepository) {
		this.peliculaRepository = peliculaRepository;
	}

	public List<Pelicula> findAll() {
		return peliculaRepository.findAll();
	}

	public Pelicula findById(Integer id) {
		return peliculaRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Película no encontrada con id: " + id));
	}

	public Pelicula save(Pelicula pelicula) {
		return peliculaRepository.save(pelicula);
	}

	public void deleteById(Integer id) {
		Pelicula pelicula = findById(id);
		peliculaRepository.delete(pelicula);
	}
}