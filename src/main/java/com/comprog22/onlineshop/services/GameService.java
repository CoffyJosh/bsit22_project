package com.comprog22.onlineshop.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.enums.GameStatus;
import com.comprog22.onlineshop.repository.GameRepo;

@Service
public class GameService {
 @Autowired
    private GameRepo gameRepo;

    public Game create(Game game) {
        return gameRepo.save(game);
    }

    public Optional<Game> findById(Long id) {
        return gameRepo.findById(id);
    }

    public List<Game> getAll() {
        return gameRepo.findAll();
    }

    public List<Game> getByStatus(GameStatus status) {
        return gameRepo.findByStatus(status);
    }

    public Game updateStatus(Long id, GameStatus status) {
        Game game = gameRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Game not found"));

        game.setStatus(status);
        return gameRepo.save(game);
    }

    public Game archive(Long id) {
        return updateStatus(id, GameStatus.DEPRECATED);
    }
}
