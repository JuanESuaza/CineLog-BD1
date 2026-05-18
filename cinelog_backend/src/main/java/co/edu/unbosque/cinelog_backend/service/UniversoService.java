package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.entity.Universo;
import co.edu.unbosque.cinelog_backend.repository.UniversoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UniversoService {

	private final UniversoRepository universoRepository;

	public UniversoService(UniversoRepository universoRepository) {
		this.universoRepository = universoRepository;
	}

	public List<Universo> findAll() {
		return universoRepository.findAll();
	}

	public Universo findById(Integer id) {
		return universoRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Universo no encontrado con id: " + id));
	}

	public Universo save(Universo universo) {
		return universoRepository.save(universo);
	}

	public void deleteById(Integer id) {
		Universo universo = findById(id);
		universoRepository.delete(universo);
	}
}