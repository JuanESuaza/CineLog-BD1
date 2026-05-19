package co.edu.unbosque.cinelog_backend.controller;

import co.edu.unbosque.cinelog_backend.entity.Genero;
import co.edu.unbosque.cinelog_backend.service.GeneroService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/generos")
@CrossOrigin(origins = "http://localhost:5173")
public class GeneroController {

	private final GeneroService generoService;

	public GeneroController(GeneroService generoService) {
		this.generoService = generoService;
	}

	@GetMapping
	public List<Genero> findAll() {
		return generoService.findAll();
	}

	@GetMapping("/{id}")
	public Genero findById(@PathVariable Integer id) {
		return generoService.findById(id);
	}
}