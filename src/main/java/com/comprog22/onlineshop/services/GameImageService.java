package com.comprog22.onlineshop.services;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class GameImageService {

    @Value("${app.upload.dir}")
    private String uploadDir;

    /**
     * Saves an uploaded image for a game. Creates the game's folder
     * automatically if it doesn't exist yet.
     */
    public void saveGameImage(Long gameId, String imageType, MultipartFile file) throws IOException {
        Path gameDir = Path.of(uploadDir, gameId.toString());
        Files.createDirectories(gameDir);

        // Delete any existing file for this imageType across all known extensions,
        // so a new upload doesn't get shadowed by a stale file in a higher-priority
        // format
        String[] exts = { "webp", "svg", "png", "jpg" };
        for (String e : exts) {
            Files.deleteIfExists(gameDir.resolve(imageType + "." + e));
        }

        String ext = file.getOriginalFilename()
                .substring(file.getOriginalFilename().lastIndexOf('.') + 1);

        Path target = gameDir.resolve(imageType + "." + ext);
        file.transferTo(target);
    }

    /**
     * Resolves the actual file Path for a game's image, or null if it doesn't
     * exist.
     */
    public Path resolveImagePath(Long gameId, String imageType) {
        Path gameDir = Path.of(uploadDir, gameId.toString());
        return findImageResolve(gameDir, imageType);
    }

    /**
     * Backfill: creates folders for a list of game IDs (run once for existing
     * games).
     */
    public void ensureDirectoriesExist(java.util.List<Long> gameIds) {
        for (Long id : gameIds) {
            try {
                Files.createDirectories(Path.of(uploadDir, id.toString()));
            } catch (IOException e) {
                System.err.println("Failed to create folder for game " + id + ": " + e.getMessage());
            }
        }
    }

    private Path findImageResolve(Path dir, String imageType) {
        String[] ext = { "webp", "svg", "png", "jpg" };

        for (String e : ext) {
            Path imgFile = dir.resolve(imageType + "." + e);
            if (Files.exists(imgFile)) {
                return imgFile;
            }
        }

        return null;
    }
}