package co.edu.unbosque.cinelog_backend.repository;

import co.edu.unbosque.cinelog_backend.entity.Saga;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SagaRepository extends JpaRepository<Saga, Integer> {
}