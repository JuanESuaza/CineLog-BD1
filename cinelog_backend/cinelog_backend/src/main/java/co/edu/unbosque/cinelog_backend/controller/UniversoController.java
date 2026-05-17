package co.edu.unbosque.cinelog_backend.controller;

import co.edu.unbosque.cinelog_backend.entity.Universo;
import co.edu.unbosque.cinelog_backend.service.UniversoService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/universos")
@CrossOrigin(origins = "http://localhost:5173")
public class UniversoController {

	private final UniversoService universoService;

	public UniversoController(UniversoService universoService) {
		this.universoService = universoService;
	}

	@GetMapping
	public List<Universo> findAll() {
		return universoService.findAll();
	}

	@GetMapping("/{id}")
	public Universo findById(@PathVariable Integer id) {
		return universoService.findById(id);
	}

	@PostMapping
	public Universo save(@RequestBody Universo universo) {
		return universoService.save(universo);
	}

	@PutMapping("/{id}")
	public Universo update(@PathVariable Integer id, @RequestBody Universo universo) {
		universo.setIdUniverso(id);
		return universoService.save(universo);
	}

	@DeleteMapping("/{id}")
	public void deleteById(@PathVariable Integer id) {
		universoService.deleteById(id);
	}
}