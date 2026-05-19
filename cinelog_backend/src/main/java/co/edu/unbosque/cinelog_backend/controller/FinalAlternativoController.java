package co.edu.unbosque.cinelog_backend.controller;

import co.edu.unbosque.cinelog_backend.dto.FinalAlternativoRequest;
import co.edu.unbosque.cinelog_backend.service.FinalAlternativoService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:5173")
public class FinalAlternativoController {

	private final FinalAlternativoService finalAlternativoService;

	public FinalAlternativoController(FinalAlternativoService finalAlternativoService) {
		this.finalAlternativoService = finalAlternativoService;
	}

	@GetMapping("/finales/{id_contenido}")
	public Map<String, Object> obtenerFinalDelUsuario(@RequestHeader("Authorization") String authorizationHeader,
			@PathVariable Integer id_contenido) {
		return finalAlternativoService.obtenerFinalDelUsuario(authorizationHeader, id_contenido);
	}

	@GetMapping("/finales/{id_contenido}/todos")
	public List<Map<String, Object>> obtenerTodosLosFinales(@PathVariable Integer id_contenido) {
		return finalAlternativoService.obtenerTodosLosFinales(id_contenido);
	}

	@PostMapping("/finales")
	public Map<String, Object> guardarFinal(@RequestHeader("Authorization") String authorizationHeader,
			@RequestBody FinalAlternativoRequest request) {
		return finalAlternativoService.guardarFinal(authorizationHeader, request);
	}

	@GetMapping("/mis-finales")
	public List<Map<String, Object>> obtenerMisFinales(@RequestHeader("Authorization") String authorizationHeader) {
		return finalAlternativoService.obtenerMisFinales(authorizationHeader);
	}
}