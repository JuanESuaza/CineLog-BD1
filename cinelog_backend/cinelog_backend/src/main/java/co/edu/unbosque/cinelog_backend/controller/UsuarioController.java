package co.edu.unbosque.cinelog_backend.controller;

import co.edu.unbosque.cinelog_backend.entity.Usuario;
import co.edu.unbosque.cinelog_backend.service.UsuarioService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/usuarios")
@CrossOrigin(origins = "http://localhost:5173")
public class UsuarioController {

	private final UsuarioService usuarioService;

	public UsuarioController(UsuarioService usuarioService) {
		this.usuarioService = usuarioService;
	}

	@GetMapping
	public List<Usuario> findAll() {
		return usuarioService.findAll();
	}

	@GetMapping("/{id}")
	public Usuario findById(@PathVariable Integer id) {
		return usuarioService.findById(id);
	}

	@PostMapping
	public Usuario save(@RequestBody Usuario usuario) {
		return usuarioService.save(usuario);
	}

	@PutMapping("/{id}")
	public Usuario update(@PathVariable Integer id, @RequestBody Usuario usuario) {
		usuario.setIdUsuario(id);
		return usuarioService.save(usuario);
	}

	@DeleteMapping("/{id}")
	public void deleteById(@PathVariable Integer id) {
		usuarioService.deleteById(id);
	}
}