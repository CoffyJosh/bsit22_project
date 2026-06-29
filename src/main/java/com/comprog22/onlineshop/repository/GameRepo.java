package com.comprog22.onlineshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.enums.GameStatus;

public interface GameRepo extends JpaRepository<Game, Long> {
    List<Game> findByStatus(GameStatus status);

    List<Game> findTop5ByOrderByCreatedAtDesc();

    List<Game> findAll();

    List<Game> findAllByOrderByNameAsc();

    Optional<Game> findById(Long id);

    Optional<Game> findByName(String name);

    // ---------- Pagination ----------
    Page<Game> findAll(Pageable pageable);

    Page<Game> findByStatus(GameStatus status, Pageable pageable);

    @Query("""
            SELECT g
            FROM Game g
            WHERE LOWER(g.name) LIKE LOWER(CONCAT('%', :search, '%'))
            """)
    Page<Game> findByNameContaining(@Param("search") String search, Pageable pageable);

    @Query("""
            SELECT g
            FROM Game g
            WHERE g.status = :status
              AND LOWER(g.name) LIKE LOWER(CONCAT('%', :search, '%'))
            """)
    Page<Game> findByStatusAndNameContaining(@Param("status") GameStatus status, @Param("search") String search,
            Pageable pageable);
}