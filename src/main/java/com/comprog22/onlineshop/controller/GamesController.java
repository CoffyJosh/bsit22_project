package com.comprog22.onlineshop.controller;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.entities.GameImage;
import com.comprog22.onlineshop.services.GameService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/games")
public class GamesController {

    private final GameService gameService;

    public GamesController(GameService gameService) {
        this.gameService = gameService;
    }

    @GetMapping("/popular")
    public ResponseEntity<List<Game>> getPopularGames() {
        return ResponseEntity.ok(gameService.getRecent());
    }
    
    @GetMapping("/all")
    public ResponseEntity<List<Game>> getAllGames() {
        return ResponseEntity.ok(gameService.getAllByOrderAsc());
    }

    @GetMapping("/{gameId}/files/image/{imageType}/{sortOrder}")
    public ResponseEntity<String> getImageUrl(@PathVariable Long gameId, @PathVariable String imageType, @PathVariable int sortOrder, @RequestHeader(value = "Referer", required = false) String referer) {
        if (referer == null || !referer.startsWith("http://localhost:8080/")) {
            return ResponseEntity.status(403).build();
        }
        
        try{
            GameImage image = gameService.getGameImage(gameId, imageType, sortOrder).orElseThrow();
            return ResponseEntity.ok(image.getUrl());

        } catch(Exception e){
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/{gameId}/info")
    public ResponseEntity<Game> getGameInfo(@PathVariable Long gameId, @RequestHeader(value = "Referer", required = false) String referer){
        if (referer == null || !referer.startsWith("http://localhost:8080/")) {
            return ResponseEntity.status(403).build();
        }
        
        return ResponseEntity.ok(gameService.findById(gameId).orElseThrow());
    }
}