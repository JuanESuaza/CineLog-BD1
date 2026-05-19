package co.edu.unbosque.cinelog_backend.controller;

import co.edu.unbosque.cinelog_backend.entity.Episodio;
import co.edu.unbosque.cinelog_backend.service.EpisodioService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/episodios")
@CrossOrigin(origins = "http://localhost:5173")
public class EpisodioController {

	private final EpisodioService episodioService;

	public EpisodioController(EpisodioService episodioService) {
		this.episodioService = episodioService;
	}

	@GetMapping
	public List<Episodio> findAll() {
		return episodioService.findAll();
	}

	@GetMapping("/{id}")
	public Episodio findById(@PathVariable Integer id) {
		return episodioService.findById(id);
	}

	@PostMapping
	public Episodio save(@RequestBody Episodio episodio) {
		return episodioService.save(episodio);
	}

	@PutMapping("/{id}")
	public Episodio update(@PathVariable Integer id, @RequestBody Episodio episodio) {
		episodio.setIdEpisodio(id);
		return episodioService.save(episodio);
	}

	@DeleteMapping("/{id}")
	public void deleteById(@PathVariable Integer id) {
		episodioService.deleteById(id);
	}
}