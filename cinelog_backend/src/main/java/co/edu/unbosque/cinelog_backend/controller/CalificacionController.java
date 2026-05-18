package co.edu.unbosque.cinelog_backend.controller;

import co.edu.unbosque.cinelog_backend.dto.CalificacionRequest;
import co.edu.unbosque.cinelog_backend.service.CalificacionService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/calificaciones")
@CrossOrigin(origins = "http://localhost:5173")
public class CalificacionController {

	private final CalificacionService calificacionService;

	public CalificacionController(CalificacionService calificacionService) {
		this.calificacionService = calificacionService;
	}

	@GetMapping("/{id_contenido}")
	public List<Map<String, Object>> obtenerCalificacionesPorContenido(@PathVariable Integer id_contenido) {
		return calificacionService.obtenerCalificacionesPorContenido(id_contenido);
	}

	@PostMapping
	public Map<String, Object> guardarCalificacion(@RequestHeader("Authorization") String authorizationHeader,
			@RequestBody CalificacionRequest request) {
		return calificacionService.guardarCalificacion(authorizationHeader, request);
	}
}