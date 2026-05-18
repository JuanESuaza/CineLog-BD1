package co.edu.unbosque.cinelog_backend.service;

import co.edu.unbosque.cinelog_backend.dto.AuthResponse;
import co.edu.unbosque.cinelog_backend.dto.LoginRequest;
import co.edu.unbosque.cinelog_backend.dto.RegisterRequest;
import co.edu.unbosque.cinelog_backend.dto.UsuarioResponse;
import co.edu.unbosque.cinelog_backend.entity.Usuario;
import co.edu.unbosque.cinelog_backend.repository.UsuarioRepository;
import co.edu.unbosque.cinelog_backend.security.JwtUtil;
import co.edu.unbosque.cinelog_backend.security.PasswordUtil;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

	private final UsuarioRepository usuarioRepository;
	private final JwtUtil jwtUtil;
	private final PasswordUtil passwordUtil;

	public AuthService(UsuarioRepository usuarioRepository, JwtUtil jwtUtil, PasswordUtil passwordUtil) {
		this.usuarioRepository = usuarioRepository;
		this.jwtUtil = jwtUtil;
		this.passwordUtil = passwordUtil;
	}

	public AuthResponse register(RegisterRequest request) {

		if (usuarioRepository.existsByCorreoElectronico(request.getCorreo_electronico())) {
			throw new RuntimeException("El correo electrónico ya está registrado");
		}

		if (usuarioRepository.existsByNombreUsuario(request.getNombre_usuario())) {
			throw new RuntimeException("El nombre de usuario ya está en uso");
		}

		Usuario usuario = new Usuario();

		usuario.setPrimerNombre(request.getPrimer_nombre());
		usuario.setPrimerApellido(request.getPrimer_apellido());
		usuario.setNombreUsuario(request.getNombre_usuario());
		usuario.setCorreoElectronico(request.getCorreo_electronico());
		usuario.setContrasenia(passwordUtil.encryptPassword(request.getContrasenia()));
		usuario.setFechaNacimiento(request.getFecha_nacimiento());

		Usuario usuarioGuardado = usuarioRepository.save(usuario);

		String token = jwtUtil.generateToken(usuarioGuardado.getIdUsuario(), usuarioGuardado.getCorreoElectronico());

		UsuarioResponse usuarioResponse = new UsuarioResponse(usuarioGuardado.getIdUsuario(),
				usuarioGuardado.getNombreUsuario(), usuarioGuardado.getPrimerNombre(),
				usuarioGuardado.getPrimerApellido(), usuarioGuardado.getCorreoElectronico());

		return new AuthResponse(token, usuarioResponse);
	}

	public AuthResponse login(LoginRequest request) {

		Usuario usuario = usuarioRepository.findByCorreoElectronico(request.getCorreo_electronico())
				.orElseThrow(() -> new RuntimeException("Correo o contraseña incorrectos"));

		boolean passwordValida = passwordUtil.matches(request.getContrasenia(), usuario.getContrasenia());

		if (!passwordValida) {
			throw new RuntimeException("Correo o contraseña incorrectos");
		}

		String token = jwtUtil.generateToken(usuario.getIdUsuario(), usuario.getCorreoElectronico());

		UsuarioResponse usuarioResponse = new UsuarioResponse(usuario.getIdUsuario(), usuario.getNombreUsuario(),
				usuario.getPrimerNombre(), usuario.getPrimerApellido(), usuario.getCorreoElectronico());

		return new AuthResponse(token, usuarioResponse);
	}

	public UsuarioResponse perfil(String authorizationHeader) {

		String token = jwtUtil.extractTokenFromHeader(authorizationHeader);
		Integer idUsuario = jwtUtil.getIdUsuarioFromToken(token);

		Usuario usuario = usuarioRepository.findById(idUsuario)
				.orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

		return new UsuarioResponse(usuario.getIdUsuario(), usuario.getNombreUsuario(), usuario.getPrimerNombre(),
				usuario.getPrimerApellido(), usuario.getCorreoElectronico());
	}
}