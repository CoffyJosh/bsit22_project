package com.comprog22.onlineshop.services;

import java.util.List;
import java.util.Optional;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;

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
    public String getGameImageDir(Long gameId, String imageType) {
        String gameName = findGameById(gameId).getName().replace(":", "_");
        Path imgPath = Path.of("src/main/resources/static/images/games", gameName);
        Path imgFile = findImageResolve(imgPath, imageType);

        if (imgFile == null) {
            return null;
        }

        return "/images/games/" + gameName + "/" + imgFile.getFileName().toString();
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
