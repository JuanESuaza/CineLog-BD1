package co.edu.unbosque.cinelog_backend.controller;

import co.edu.unbosque.cinelog_backend.entity.Pelicula;
import co.edu.unbosque.cinelog_backend.service.PeliculaService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/peliculas")
@CrossOrigin(origins = "http://localhost:5173")
public class PeliculaController {

	private final PeliculaService peliculaService;

	public PeliculaController(PeliculaService peliculaService) {
		this.peliculaService = peliculaService;
	}

	@GetMapping
	public List<Pelicula> findAll() {
		return peliculaService.findAll();
	}

	@GetMapping("/{id}")
	public Pelicula findById(@PathVariable Integer id) {
		return peliculaService.findById(id);
	}

	@PostMapping
	public Pelicula save(@RequestBody Pelicula pelicula) {
		return peliculaService.save(pelicula);
	}

	@PutMapping("/{id}")
	public Pelicula update(@PathVariable Integer id, @RequestBody Pelicula pelicula) {
		pelicula.setIdContenido(id);
		return peliculaService.save(pelicula);
	}

	@DeleteMapping("/{id}")
	public void deleteById(@PathVariable Integer id) {
		peliculaService.deleteById(id);
	}
}