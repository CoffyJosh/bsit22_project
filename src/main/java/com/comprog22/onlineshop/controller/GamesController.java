package com.comprog22.onlineshop.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.entities.TopupPackage;
import com.comprog22.onlineshop.services.GameService;
import com.comprog22.onlineshop.services.TopupPackageService;

@RestController
@RequestMapping("/api/games")
public class GamesController {

    private final GameService gameService;
    private final TopupPackageService topupPackageService;

    public GamesController(GameService gameService, TopupPackageService topupPackageService) {
        this.gameService = gameService;
        this.topupPackageService = topupPackageService;
    }

    @GetMapping("/popular")
    public ResponseEntity<List<Game>> getPopularGames() {
        return ResponseEntity.ok(gameService.getRecent());
    }
    
    @GetMapping("/all")
    public ResponseEntity<List<Game>> getAllGames() {
        return ResponseEntity.ok(gameService.getAllByOrderAsc());
    }

    @GetMapping("/{gameId}/image/{imageType}")
    public ResponseEntity<String> getImageUrl(@PathVariable Long gameId, @PathVariable String imageType) { 
        try{
            String imgDir = gameService.getGameImageDir(gameId, imageType);
            return ResponseEntity.ok(imgDir);

        } catch(Exception e){
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/{gameId}/info")
    public ResponseEntity<Game> getGameInfo(@PathVariable Long gameId){
        return ResponseEntity.ok(gameService.findById(gameId).orElseThrow());
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
}