package com.comprog22.onlineshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.comprog22.onlineshop.entities.Game;

public interface GameRepo extends JpaRepository<Game, Long> {

}
