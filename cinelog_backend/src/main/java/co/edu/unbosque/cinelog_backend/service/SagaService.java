package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.entity.Saga;
import co.edu.unbosque.cinelog_backend.repository.SagaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SagaService {

	private final SagaRepository sagaRepository;

	public SagaService(SagaRepository sagaRepository) {
		this.sagaRepository = sagaRepository;
	}

	public List<Saga> findAll() {
		return sagaRepository.findAll();
	}

	public Saga findById(Integer id) {
		return sagaRepository.findById(id).orElseThrow(() -> new RuntimeException("Saga no encontrada con id: " + id));
	}

	public Saga save(Saga saga) {
		return sagaRepository.save(saga);
	}

	public void deleteById(Integer id) {
		Saga saga = findById(id);
		sagaRepository.delete(saga);
	}
}