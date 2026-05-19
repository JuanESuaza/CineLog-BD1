package co.edu.unbosque.cinelog_backend.controller;

import co.edu.unbosque.cinelog_backend.entity.Temporada;
import co.edu.unbosque.cinelog_backend.service.EpisodioService;
import co.edu.unbosque.cinelog_backend.service.TemporadaService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/temporadas")
@CrossOrigin(origins = "http://localhost:5173")
public class TemporadaController {

    private final TemporadaService temporadaService;
    private final EpisodioService episodioService;

    public TemporadaController(
            TemporadaService temporadaService,
            EpisodioService episodioService
    ) {
        this.temporadaService = temporadaService;
        this.episodioService = episodioService;
    }

    @GetMapping
    public List<Temporada> findAll() {
        return temporadaService.findAll();
    }

    @GetMapping("/{id}")
    public Temporada findById(@PathVariable Integer id) {
        return temporadaService.findById(id);
    }

    @GetMapping("/{id}/episodios")
    public List<Map<String, Object>> obtenerEpisodiosPorTemporada(@PathVariable Integer id) {
        return episodioService.obtenerEpisodiosPorTemporada(id);
    }

    @PostMapping
    public Temporada save(@RequestBody Temporada temporada) {
        return temporadaService.save(temporada);
    }

    @PutMapping("/{id}")
    public Temporada update(@PathVariable Integer id, @RequestBody Temporada temporada) {
        temporada.setIdTemporada(id);
        return temporadaService.save(temporada);
    }

    @DeleteMapping("/{id}")
    public void deleteById(@PathVariable Integer id) {
        temporadaService.deleteById(id);
    }
}