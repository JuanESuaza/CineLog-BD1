package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.entity.Usuario;
import co.edu.unbosque.cinelog_backend.repository.UsuarioRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsuarioService {

	private final UsuarioRepository usuarioRepository;

	public UsuarioService(UsuarioRepository usuarioRepository) {
		this.usuarioRepository = usuarioRepository;
	}

	public List<Usuario> findAll() {
		return usuarioRepository.findAll();
	}

	public Usuario findById(Integer id) {
		return usuarioRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Usuario no encontrado con id: " + id));
	}

	public Usuario save(Usuario usuario) {
		return usuarioRepository.save(usuario);
	}

	public void deleteById(Integer id) {
		Usuario usuario = findById(id);
		usuarioRepository.delete(usuario);
	}
}