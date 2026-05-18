package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.entity.Genero;
import co.edu.unbosque.cinelog_backend.repository.GeneroRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GeneroService {

	private final GeneroRepository generoRepository;

	public GeneroService(GeneroRepository generoRepository) {
		this.generoRepository = generoRepository;
	}

	public List<Genero> findAll() {
		return generoRepository.findAll();
	}

	public Genero findById(Integer id) {
		return generoRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Género no encontrado con id: " + id));
	}

	public Genero save(Genero genero) {
		return generoRepository.save(genero);
	}

	public void deleteById(Integer id) {
		Genero genero = findById(id);
		generoRepository.delete(genero);
	}
}