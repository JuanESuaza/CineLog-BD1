package co.edu.unbosque.cinelog_backend.repository;

import co.edu.unbosque.cinelog_backend.entity.Universo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UniversoRepository extends JpaRepository<Universo, Integer> {
}