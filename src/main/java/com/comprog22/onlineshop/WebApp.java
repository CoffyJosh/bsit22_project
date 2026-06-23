package com.comprog22.onlineshop;

import java.util.List;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.repository.GameRepo;
import com.comprog22.onlineshop.services.GameImageService;

@SpringBootApplication
public class WebApp {
	public static void main(String[] args) {
        ConfigurableApplicationContext context = SpringApplication.run(WebApp.class, args);

		GameRepo gameRepo = context.getBean(GameRepo.class);
		GameImageService gameImageService = context.getBean(GameImageService.class);

		List<Long> ids = gameRepo.findAll().stream()
				.map(Game::getId)
				.toList();

		gameImageService.ensureDirectoriesExist(ids);
	}
}
