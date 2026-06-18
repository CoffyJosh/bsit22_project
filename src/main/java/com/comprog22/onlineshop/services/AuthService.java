package com.comprog22.onlineshop.services;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.enums.UserStatus;

import lombok.RequiredArgsConstructor;

import com.comprog22.onlineshop.dto.CreateUserChangeRequest;

@Service
@RequiredArgsConstructor
public class AuthService {
    
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public User register(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setStatus(UserStatus.ACTIVE);
        return userService.save(user);
    }

    public List<User> registerByBatch(List<User> users) {
        return users.stream().map(this::register).toList();
    }

    public User oauthLogin(String email, String name) {
        return userService.findByEmail(email)
                .orElseGet(() -> {
                    User user = new User();
                    user.setEmail(email);
                    user.setName(name);
                    user.setPassword(null);
                    user.setStatus(UserStatus.ACTIVE);
                    return userService.save(user);
                });
    }

    public User updatePassword(Long userId, String rawPassword) {
        User user = userService.findById(userId).orElseThrow();

        if (user.getPassword() != null && passwordEncoder.matches(rawPassword, user.getPassword())) {
            throw new IllegalArgumentException("New password must be different from your current password.");
        }

        user.setPassword(passwordEncoder.encode(rawPassword));
        return userService.save(user);
    }

    public User updateUserProfile(CreateUserChangeRequest request) {
        User u = userService.findById(request.getId()).orElseThrow();

        if (request.getName() != null) u.setName(request.getName());
        if (request.getEmail() != null) u.setEmail(request.getEmail());
        if (request.getPassword() != null) u.setPassword(passwordEncoder.encode(request.getPassword()));

        return userService.save(u);
    }
}