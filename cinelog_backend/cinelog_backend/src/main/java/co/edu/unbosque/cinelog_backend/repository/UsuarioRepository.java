package co.edu.unbosque.cinelog_backend.repository;

import co.edu.unbosque.cinelog_backend.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

	Optional<Usuario> findByCorreoElectronico(String correoElectronico);

	boolean existsByCorreoElectronico(String correoElectronico);

	boolean existsByNombreUsuario(String nombreUsuario);
}