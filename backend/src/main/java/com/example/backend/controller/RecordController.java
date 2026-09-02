package com.example.backend.controller;

import com.example.backend.model.Record;
import com.example.backend.repository.RecordRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/records")
public class RecordController {
    private final RecordRepository repo;

    public RecordController(RecordRepository repo) {
        this.repo = repo;
    }

    @GetMapping
    public List<Record> list() { return repo.findAll(); }

    @GetMapping("/{id}")
    public ResponseEntity<Record> get(@PathVariable Long id) {
        return repo.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Record create(@RequestBody Record r) { return repo.save(r); }

    @PutMapping("/{id}")
    public ResponseEntity<Record> update(@PathVariable Long id, @RequestBody Record in) {
        return repo.findById(id).map(existing -> {
            existing.setTitle(in.getTitle());
            existing.setCategory(in.getCategory());
            existing.setDescription(in.getDescription());
            existing.setLat(in.getLat());
            existing.setLng(in.getLng());
            existing.setImageUrls(in.getImageUrls());
            repo.save(existing);
            return ResponseEntity.ok(existing);
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        repo.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
