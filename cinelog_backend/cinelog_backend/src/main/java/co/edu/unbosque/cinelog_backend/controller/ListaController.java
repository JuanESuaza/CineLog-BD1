package co.edu.unbosque.cinelog_backend.controller;

import co.edu.unbosque.cinelog_backend.dto.AgregarContenidoListaRequest;
import co.edu.unbosque.cinelog_backend.dto.ListaRequest;
import co.edu.unbosque.cinelog_backend.dto.MoverContenidoRequest;
import co.edu.unbosque.cinelog_backend.service.ListaService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/listas")
@CrossOrigin(origins = "http://localhost:5173")
public class ListaController {

	private final ListaService listaService;

	public ListaController(ListaService listaService) {
		this.listaService = listaService;
	}

	@GetMapping
	public List<Map<String, Object>> obtenerListasDelUsuario(
			@RequestHeader("Authorization") String authorizationHeader) {
		return listaService.obtenerListasDelUsuario(authorizationHeader);
	}

	@GetMapping("/{id_lista}/contenidos")
	public List<Map<String, Object>> obtenerContenidosDeLista(
			@RequestHeader("Authorization") String authorizationHeader, @PathVariable Integer id_lista) {
		return listaService.obtenerContenidosDeLista(authorizationHeader, id_lista);
	}

	@PostMapping
	public Map<String, Object> crearLista(@RequestHeader("Authorization") String authorizationHeader,
			@RequestBody ListaRequest request) {
		return listaService.crearLista(authorizationHeader, request);
	}

	@PostMapping("/{id_lista}/contenidos")
	public Map<String, Object> agregarContenidoALista(@RequestHeader("Authorization") String authorizationHeader,
			@PathVariable Integer id_lista, @RequestBody AgregarContenidoListaRequest request) {
		return listaService.agregarContenidoALista(authorizationHeader, id_lista, request);
	}

	@DeleteMapping("/{id_lista}/contenidos/{id_contenido}")
	public Map<String, Object> eliminarContenidoDeLista(@RequestHeader("Authorization") String authorizationHeader,
			@PathVariable Integer id_lista, @PathVariable Integer id_contenido) {
		return listaService.eliminarContenidoDeLista(authorizationHeader, id_lista, id_contenido);
	}

	@DeleteMapping("/{id_lista}")
	public Map<String, Object> eliminarLista(@RequestHeader("Authorization") String authorizationHeader,
			@PathVariable Integer id_lista) {
		return listaService.eliminarLista(authorizationHeader, id_lista);
	}

	@PatchMapping("/{id_lista}/contenidos/{id_contenido}/mover")
	public Map<String, Object> moverContenido(@RequestHeader("Authorization") String authorizationHeader,
			@PathVariable Integer id_lista, @PathVariable Integer id_contenido,
			@RequestBody MoverContenidoRequest request) {
		return listaService.moverContenido(authorizationHeader, id_lista, id_contenido, request);
	}
}