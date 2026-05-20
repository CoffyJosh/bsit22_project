package com.comprog22.onlineshop.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.enums.UserStatus;
import com.comprog22.onlineshop.repository.UserRepo;

@Service
public class AuthService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public User register(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setStatus(UserStatus.ACTIVE);
        return userRepo.save(user);
    }

    public User oauthLogin(String email, String name) {
        return userRepo.findByEmail(email)
                .orElseGet(() -> {
                    User user = new User();
                    user.setEmail(email);
                    user.setName(name);
                    user.setPassword(null);
                    user.setStatus(UserStatus.ACTIVE);
                    return userRepo.save(user);
                });
    }

    public User addPassword(Long userId, String rawPassword) {
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        user.setPassword(passwordEncoder.encode(rawPassword));
        return userRepo.save(user);
    }
}
