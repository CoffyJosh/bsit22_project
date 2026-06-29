package com.comprog22.onlineshop.controller;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.enums.GameStatus;
import com.comprog22.onlineshop.services.GameService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class GamePageController {
    private final GameService gameService;

    @GetMapping("/game")
    public String checkoutPage(@RequestParam("id") Long id, Model model) {
        Game game = gameService.findGameById(id);

        if (game == null || game.getStatus() != GameStatus.ACTIVE) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Game not available");
        }

        model.addAttribute("game", game);
        return "game";
    }
}
