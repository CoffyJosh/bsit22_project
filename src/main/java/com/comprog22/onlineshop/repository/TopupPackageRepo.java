package com.comprog22.onlineshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.entities.TopupPackage;
import com.comprog22.onlineshop.enums.TopupPackageStatus;

import java.util.List;

public interface TopupPackageRepo extends JpaRepository<TopupPackage, Long> {

    List<TopupPackage> findByGame(Game game);

    List<TopupPackage> findByStatus(TopupPackageStatus status);

    List<TopupPackage> findByGameAndStatus(Game game, TopupPackageStatus status);

    int countByGameId(Long gameId);
}