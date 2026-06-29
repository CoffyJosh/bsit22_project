package com.comprog22.onlineshop.config;

import com.comprog22.onlineshop.enums.Role;
import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.services.AuthService;
import com.comprog22.onlineshop.services.UserService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataSeedConfig {

    @Bean
    public CommandLineRunner seedAdmin(AuthService authService, UserService userService) {
        return args -> {
            if (userService.findByEmail("admin@auragames.com").isEmpty()) {
                User admin = new User();
                admin.setName("Aura Games Admin");
                admin.setEmail("admin@auragames.com");
                admin.setPassword("admin123");
                admin.setRole(Role.ADMIN);
                authService.register(admin);
            }
        };
    }
}