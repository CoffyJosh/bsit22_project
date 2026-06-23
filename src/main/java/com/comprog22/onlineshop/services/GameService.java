package com.comprog22.onlineshop.services;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.enums.GameStatus;
import com.comprog22.onlineshop.repository.GameRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class GameService {

    private final GameRepo gameRepo;

    public Game create(Game game) {
        return gameRepo.save(game);
    }

    public Optional<Game> findById(Long id) {
        return gameRepo.findById(id);
    }

    public Game findGameById(Long id) {
        return gameRepo.findById(id).orElseThrow();
    }

    public Game findGameByName(String name) {
        return gameRepo.findByName(name).orElseThrow();
    }

    public List<Game> getAll() {
        return gameRepo.findAll();
    }

    public List<Game> getAllByOrderAsc() {
        return gameRepo.findAllByOrderByNameAsc();
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

    public List<Game> getRecent() {
        return gameRepo.findTop5ByOrderByCreatedAtDesc();
    }



    // Image Finder
    private static final String RESOURCE_BASE = "src/main/resources/static/images/games";

    public String getGameImageDir(Long gameId, String imageType) {
        String gameName = findGameById(gameId).getName().replace(":", "_");
        Path resourcePath = Path.of(RESOURCE_BASE, gameName);
        Path imgFile = findImageResolve(resourcePath, imageType);

        if (imgFile != null) {
            return "/images/games/" + gameName + "/" + imgFile.getFileName().toString();
        }

        return null;
    }

    private Path findImageResolve(Path path, String imageType) {
        String[] ext = { "webp", "svg", "png", "jpg" };

        for (String e : ext) {
            Path imgFile = path.resolve(imageType + "." + e);
            if (Files.exists(imgFile)) return imgFile;
            
        }

        return null;
    }
}
