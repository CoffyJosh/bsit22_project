package com.comprog22.onlineshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.enums.GameStatus;

public interface GameRepo extends JpaRepository<Game, Long> {
    List<Game> findByStatus(GameStatus status);
    List<Game> findTop5ByOrderByCreatedAtDesc();
    List<Game> findAll();
    
    List<Game> findAllByOrderByNameAsc();
    Optional<Game> findById(Long id);
}
