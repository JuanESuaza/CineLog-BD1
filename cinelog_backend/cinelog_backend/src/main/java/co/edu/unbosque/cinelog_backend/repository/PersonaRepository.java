package co.edu.unbosque.cinelog_backend.repository;

import co.edu.unbosque.cinelog_backend.entity.Persona;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PersonaRepository extends JpaRepository<Persona, Integer> {
}