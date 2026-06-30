package com.comprog22.onlineshop.controller;

import java.io.IOException;
import java.util.List;
import java.nio.file.Files;
import java.nio.file.Path;

import org.springframework.core.io.FileSystemResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.comprog22.onlineshop.dto.GameDetailDTO;
import com.comprog22.onlineshop.dto.GameListItemDTO;
import com.comprog22.onlineshop.dto.GameUpdateRequest;
import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.entities.TopupPackage;
import com.comprog22.onlineshop.enums.GameStatus;
import com.comprog22.onlineshop.services.GameImageService;
import com.comprog22.onlineshop.services.GameService;
import com.comprog22.onlineshop.services.TopupPackageService;

import org.springframework.core.io.Resource;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.MediaType;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/games")
public class GamesController {

    private final GameService gameService;
    private final GameImageService gameImageService;
    private final TopupPackageService topupPackageService;


    @GetMapping("/popular")
    public ResponseEntity<List<Game>> getPopularGames() {
        return ResponseEntity.ok(gameService.getPopular());
    }
    
    @GetMapping("/all")
    public ResponseEntity<List<Game>> getAllGames() {
        return ResponseEntity.ok(gameService.getAllByOrderAsc());
    }

    @GetMapping("/{gameId}/image/{imageType}")
    public ResponseEntity<Resource> getImage(@PathVariable Long gameId, @PathVariable String imageType) {
        Path imgPath = gameImageService.resolveImagePath(gameId, imageType);

        if (imgPath == null) {
            return ResponseEntity.notFound().build();
        }

        try {
            Resource resource = new FileSystemResource(imgPath);
            String contentType = Files.probeContentType(imgPath);

            return ResponseEntity.ok()
                    .contentType(contentType != null ? MediaType.parseMediaType(contentType) : MediaType.APPLICATION_OCTET_STREAM)
                    .body(resource);

        } catch (IOException e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    @GetMapping("/{gameId}/info")
    public ResponseEntity<Game> getGameInfo(@PathVariable Long gameId){
        return ResponseEntity.ok(gameService.findById(gameId).orElseThrow());
    }

    @GetMapping("/{gameId}/config-data")
    public ResponseEntity<GameDetailDTO> getGameConfigData(@PathVariable Long gameId) {
        return ResponseEntity.ok(gameService.getGameDetail(gameId));
    }

    // ---------- TOPUP PACKAGES --------------------------
    @GetMapping("/{gameId}/packages")
    public ResponseEntity<List<TopupPackage>> getGamePackages(@PathVariable Long gameId){
        Game game = gameService.findGameById(gameId);
        return ResponseEntity.ok(topupPackageService.getByGame(game));
    }

    @GetMapping("/package")
    public ResponseEntity<TopupPackage> getGamePackage(@RequestParam Long id) {
        return ResponseEntity.ok(topupPackageService.findPackageById(id));
    }

    // -------- PAGINATION STUFF ------------------------

    @GetMapping
    public ResponseEntity<Page<GameListItemDTO>> getGames(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "50") int size,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String search) {

        Pageable pageable = PageRequest.of(
                page,
                size,
                Sort.by("name").ascending());

        Page<GameListItemDTO> result;

        boolean hasStatus = status != null && !status.isBlank();
        boolean hasSearch = search != null && !search.isBlank();

        if (hasStatus && hasSearch) {

            result = gameService.getGamesByStatusAndSearchPaged(
                    GameStatus.valueOf(status.toUpperCase()),
                    search,
                    pageable);

        } else if (hasStatus) {

            result = gameService.getGamesByStatusPaged(
                    GameStatus.valueOf(status.toUpperCase()),
                    pageable);

        } else if (hasSearch) {

            result = gameService.getGamesBySearchPaged(
                    search,
                    pageable);

        } else {

            result = gameService.getAllGamesPaged(pageable);
        }

        return ResponseEntity.ok(result);
    }

    // ----------- Update --------------
    @PostMapping("/update/{gameId}")public ResponseEntity<Void> updateGame(@PathVariable Long gameId,@ModelAttribute GameUpdateRequest request) throws IOException {
        gameService.updateGame(gameId, request);
        return ResponseEntity.ok().build();
    }

    // ----------- Delete --------------
    @PostMapping("/{gameId}/delete")
    public ResponseEntity<Void> deleteGame(@PathVariable Long gameId) {
        gameService.deprecateGame(gameId);
        return ResponseEntity.ok().build();
    }

    // ----------- Create --------------
    @PostMapping("/create")
    public ResponseEntity<Game> createGame(@ModelAttribute GameUpdateRequest request) throws IOException {
        Game created = gameService.createGame(request);
        return ResponseEntity.ok(created);
    }
}