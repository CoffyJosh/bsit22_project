package com.comprog22.onlineshop.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.comprog22.onlineshop.entities.GameImage;

public interface GameImageRepo extends JpaRepository<GameImage, Long> {
    Optional<GameImage> findById(Long id);
    Optional<GameImage> findByGame_IdAndTypeAndSortOrder(Long gameId, String imageType, int sortOrder);
}
