package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.entity.Persona;
import co.edu.unbosque.cinelog_backend.repository.PersonaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PersonaService {

	private final PersonaRepository personaRepository;

	public PersonaService(PersonaRepository personaRepository) {
		this.personaRepository = personaRepository;
	}

	public List<Persona> findAll() {
		return personaRepository.findAll();
	}

	public Persona findById(Integer id) {
		return personaRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Persona no encontrada con id: " + id));
	}

	public Persona save(Persona persona) {
		return personaRepository.save(persona);
	}

	public void deleteById(Integer id) {
		Persona persona = findById(id);
		personaRepository.delete(persona);
	}
}