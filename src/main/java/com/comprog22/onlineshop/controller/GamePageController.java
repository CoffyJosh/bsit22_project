package com.comprog22.onlineshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.services.GameService;

@Controller
public class GamePageController {

    @Autowired
    private GameService gameService;

    @GetMapping("/game")
    public String checkoutPage(@RequestParam("id") Long id, Model model){
        Game game = gameService.findGameById(id);
        model.addAttribute("game", game);
        return "game";
    }
}
