package com.comprog22.onlineshop.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.comprog22.onlineshop.dto.UpdateAccountRequest;
import com.comprog22.onlineshop.dto.UpdatePasswordRequest;
import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.enums.UserStatus;
import com.comprog22.onlineshop.repository.UserRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepo userRepo;
    private final PasswordEncoder passwordEncoder;

    public User save(User user) {
        return userRepo.save(user);
    }

    public Optional<User> findById(Long id) {
        return userRepo.findById(id);
    }

    public Optional<User> findByEmail(String email) {
        return userRepo.findByEmail(email);
    }

    public boolean existsByName(String name){
        return userRepo.existsByName(name);
    }

    public boolean existsByEmail(String email) {
        return userRepo.existsByEmail(email);
    }

    public boolean isOAuthAccount(String email) {
        return userRepo.existsByEmailAndPasswordIsNull(email);
    }

    public List<User> getAllUsers() {
        return userRepo.findAll();
    }

    public User updateStatus(Long id, UserStatus status) {
        User user = userRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));

        user.setStatus(status);

        return userRepo.save(user);
    }

    public User deactivateAccount(Long id) {
        return updateStatus(id, UserStatus.INACTIVE);
    }

    public User updateAccount(Long userId, UpdateAccountRequest request) {
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        user.setName(request.getName());
        return userRepo.save(user);
    }

    public void updatePassword(Long userId, UpdatePasswordRequest request) {
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        if (user.getPassword() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "This account uses OAuth and has no password");
        }

        if (!passwordEncoder.matches(request.getCurrentPassword(), user.getPassword())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Current password is incorrect");
        }

        if (passwordEncoder.matches(request.getNewPassword(), user.getPassword())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "New password cannot be the same as your current password");
        }

        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userRepo.save(user);
    }
}
