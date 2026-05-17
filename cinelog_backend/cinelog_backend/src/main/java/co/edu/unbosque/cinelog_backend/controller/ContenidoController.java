package co.edu.unbosque.cinelog_backend.controller;

import co.edu.unbosque.cinelog_backend.entity.Contenido;
import co.edu.unbosque.cinelog_backend.service.ContenidoService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/contenidos")
@CrossOrigin(origins = "http://localhost:5173")
public class ContenidoController {

	private final ContenidoService contenidoService;

	public ContenidoController(ContenidoService contenidoService) {
		this.contenidoService = contenidoService;
	}

	@GetMapping
	public List<Map<String, Object>> obtenerCatalogoCompleto() {
		return contenidoService.obtenerCatalogoCompleto();
	}

	@GetMapping("/top10")
	public List<Map<String, Object>> obtenerTop10() {
		return contenidoService.obtenerTop10();
	}

	@GetMapping("/por-genero")
	public List<Map<String, Object>> obtenerPorGenero(
	        @RequestParam(value = "id_genero", required = false) Integer idGenero
	) {
	    if (idGenero == null) {
	        return contenidoService.obtenerPorGeneroAleatorio();
	    }

	    return contenidoService.obtenerPorGenero(idGenero);
	}

	@GetMapping("/{id}")
	public Map<String, Object> obtenerDetalleContenido(@PathVariable Integer id) {
		return contenidoService.obtenerDetalleContenido(id);
	}

	@PostMapping
	public Contenido save(@RequestBody Contenido contenido) {
		return contenidoService.save(contenido);
	}

	@PutMapping("/{id}")
	public Contenido update(@PathVariable Integer id, @RequestBody Contenido contenido) {
		contenido.setIdContenido(id);
		return contenidoService.save(contenido);
	}

	@DeleteMapping("/{id}")
	public void deleteById(@PathVariable Integer id) {
		contenidoService.deleteById(id);
	}
}