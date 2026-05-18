package co.edu.unbosque.cinelog_backend.controller;

import co.edu.unbosque.cinelog_backend.entity.Saga;
import co.edu.unbosque.cinelog_backend.service.SagaService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/sagas")
@CrossOrigin(origins = "http://localhost:5173")
public class SagaController {

	private final SagaService sagaService;

	public SagaController(SagaService sagaService) {
		this.sagaService = sagaService;
	}

	@GetMapping
	public List<Saga> findAll() {
		return sagaService.findAll();
	}

	@GetMapping("/{id}")
	public Saga findById(@PathVariable Integer id) {
		return sagaService.findById(id);
	}

	@PostMapping
	public Saga save(@RequestBody Saga saga) {
		return sagaService.save(saga);
	}

	@PutMapping("/{id}")
	public Saga update(@PathVariable Integer id, @RequestBody Saga saga) {
		saga.setIdSaga(id);
		return sagaService.save(saga);
	}

	@DeleteMapping("/{id}")
	public void deleteById(@PathVariable Integer id) {
		sagaService.deleteById(id);
	}
}