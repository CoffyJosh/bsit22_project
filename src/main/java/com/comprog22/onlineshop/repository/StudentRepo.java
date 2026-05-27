package com.comprog22.onlineshop.repository;

import org.springframework.data.repository.CrudRepository;
import com.comprog22.onlineshop.entities.Student;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

public interface StudentRepo extends CrudRepository<Student, Long> {
    public Student findById(Long id);
}
