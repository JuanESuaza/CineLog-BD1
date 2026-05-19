package co.edu.unbosque.cinelog_backend.controller;

import co.edu.unbosque.cinelog_backend.entity.Serie;
import co.edu.unbosque.cinelog_backend.service.SerieService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/series")
@CrossOrigin(origins = "http://localhost:5173")
public class SerieController {

	private final SerieService serieService;

	public SerieController(SerieService serieService) {
		this.serieService = serieService;
	}

	@GetMapping
	public List<Serie> findAll() {
		return serieService.findAll();
	}

	@GetMapping("/{id}")
	public Serie findById(@PathVariable Integer id) {
		return serieService.findById(id);
	}

	@PostMapping
	public Serie save(@RequestBody Serie serie) {
		return serieService.save(serie);
	}

	@PutMapping("/{id}")
	public Serie update(@PathVariable Integer id, @RequestBody Serie serie) {
		serie.setIdContenido(id);
		return serieService.save(serie);
	}

	@DeleteMapping("/{id}")
	public void deleteById(@PathVariable Integer id) {
		serieService.deleteById(id);
	}
}