package com.comprog22.onlineshop.services;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.comprog22.onlineshop.dto.GameDetailDTO;
import com.comprog22.onlineshop.dto.GameListItemDTO;
import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.entities.ProviderProduct;
import com.comprog22.onlineshop.enums.GameStatus;

import com.comprog22.onlineshop.repository.GameRepo;
import com.comprog22.onlineshop.repository.OrderItemRepo;
import com.comprog22.onlineshop.repository.OrderRepo;
import com.comprog22.onlineshop.repository.TopupPackageRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class GameService {

    private final GameRepo gameRepo;
    private final GameImageService gameImageService;

    private final OrderItemRepo orderItemRepo;
    private final OrderRepo orderRepo;
    private final TopupPackageRepo topupPackageRepo;

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


    // ---------- Pagination ----------
    public Page<GameListItemDTO> getAllGamesPaged(Pageable pageable) {
        return gameRepo.findAll(pageable).map(this::toDto);
    }

    public Page<GameListItemDTO> getGamesByStatusPaged(GameStatus status, Pageable pageable) {
        return gameRepo.findByStatus(status, pageable).map(this::toDto);
    }

    public Page<GameListItemDTO> getGamesBySearchPaged(String search, Pageable pageable) {
        return gameRepo.findByNameContaining(search, pageable).map(this::toDto);
    }

    public Page<GameListItemDTO> getGamesByStatusAndSearchPaged(GameStatus status, String search, Pageable pageable) {
        return gameRepo.findByStatusAndNameContaining(status, search, pageable).map(this::toDto);
    }

    // ------------- DTO STUFF -----------------------
    public GameDetailDTO getGameDetail(Long gameId) {
        Game game = findById(gameId)
                .orElseThrow(() -> new NoSuchElementException("Game not found: " + gameId));

        ProviderProduct pp = game.getProviderProduct();

        GameDetailDTO dto = new GameDetailDTO();
        dto.setId(game.getId());
        dto.setName(game.getName());
        dto.setPackageName(game.getPackageName());
        dto.setStatus(game.getStatus().name());
        dto.setCreatedAt(game.getCreatedAt());

        if (pp != null) {
            dto.setProviderProductId(pp.getId());
            dto.setProviderId(pp.getProvider().getId());
        }

        dto.setHasIcon(gameImageService.resolveImagePath(gameId, "icon") != null);
        dto.setHasThumbnail(gameImageService.resolveImagePath(gameId, "image") != null);
        dto.setHasBanner(gameImageService.resolveImagePath(gameId, "banner") != null);
        dto.setHasPackageImage(gameImageService.resolveImagePath(gameId, "package") != null);

        dto.setTotalSales(orderItemRepo.countByGameId(gameId));
        dto.setRevenue(orderRepo.sumRevenueByGameId(gameId));
        dto.setPackagesCount(topupPackageRepo.countByGameId(gameId));

        return dto;
    }


    // ---------- UPDATE ----------
    public void updateGame(Long gameId, String name, String packageName, String status,
            MultipartFile icon, MultipartFile thumbnail,
            MultipartFile banner, MultipartFile packageImage) throws IOException {

        Game game = findById(gameId)
                .orElseThrow(() -> new NoSuchElementException("Game not found: " + gameId));

        game.setName(name);
        game.setPackageName(packageName);
        game.setStatus(GameStatus.valueOf(status));
        gameRepo.save(game);

        if (icon != null && !icon.isEmpty()) {
            gameImageService.saveGameImage(gameId, "icon", icon);
        }
        if (thumbnail != null && !thumbnail.isEmpty()) {
            gameImageService.saveGameImage(gameId, "thumbnail", thumbnail);
        }
        if (banner != null && !banner.isEmpty()) {
            gameImageService.saveGameImage(gameId, "banner", banner);
        }
        if (packageImage != null && !packageImage.isEmpty()) {
            gameImageService.saveGameImage(gameId, "package", packageImage);
        }
    }



    // ---------- Mapper ----------
    private GameListItemDTO toDto(Game game) {
        String imageUrl = "/api/games/" + game.getId() + "/image/icon";

        return new GameListItemDTO(
                game.getId(),
                game.getName(),
                imageUrl,
                game.getPackageName(),
                game.getStatus().name(),
                game.getCreatedAt());
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
