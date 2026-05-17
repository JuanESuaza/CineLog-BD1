package co.edu.unbosque.cinelog_backend.controller;

import co.edu.unbosque.cinelog_backend.entity.Persona;
import co.edu.unbosque.cinelog_backend.service.PersonaService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/personas")
@CrossOrigin(origins = "http://localhost:5173")
public class PersonaController {

	private final PersonaService personaService;

	public PersonaController(PersonaService personaService) {
		this.personaService = personaService;
	}

	@GetMapping
	public List<Persona> findAll() {
		return personaService.findAll();
	}

	@GetMapping("/{id}")
	public Persona findById(@PathVariable Integer id) {
		return personaService.findById(id);
	}

	@PostMapping
	public Persona save(@RequestBody Persona persona) {
		return personaService.save(persona);
	}

	@PutMapping("/{id}")
	public Persona update(@PathVariable Integer id, @RequestBody Persona persona) {
		persona.setIdPersona(id);
		return personaService.save(persona);
	}

	@DeleteMapping("/{id}")
	public void deleteById(@PathVariable Integer id) {
		personaService.deleteById(id);
	}
}