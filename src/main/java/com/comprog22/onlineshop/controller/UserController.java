package com.comprog22.onlineshop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.comprog22.onlineshop.dto.UpdateAccountRequest;
import com.comprog22.onlineshop.dto.UpdatePasswordRequest;
import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.services.UserService;

import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.http.HttpStatus;

import java.util.Map;

import org.springframework.security.crypto.password.PasswordEncoder;

import com.comprog22.onlineshop.enums.UserStatus;



@RestController
@RequiredArgsConstructor
@RequestMapping("/api/user")
public class UserController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    @GetMapping("/me")
    public User me(@AuthenticationPrincipal UserDetails userDetails) {
        return userService.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));
    }

    // Get all user (admin only)
    @GetMapping("/all")
    @PreAuthorize("hasRole('ADMIN')")
    public List<User> getAllUsers() {
        return userService.getAllUsers();
    }

    // Get user by id
    @GetMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public User getById(@PathVariable Long id) {
        return userService.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
    }

    // Update user Status
    @PutMapping("/{id}/status")
    @PreAuthorize("hasRole('ADMIN')")
    public User updateStatus(
            @PathVariable Long id,
            @RequestParam UserStatus status) {
        return userService.updateStatus(id, status);
    } 

    @PutMapping("/me")
    public ResponseEntity<User> updateAccount(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestBody UpdateAccountRequest request) {

        User current = userService.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));

        User updated = userService.updateAccount(current.getId(), request);
        return ResponseEntity.ok(updated);
    }

    @PutMapping("/me/password")
    public ResponseEntity<?> updatePassword( @AuthenticationPrincipal UserDetails userDetails,@RequestBody UpdatePasswordRequest request) {
        try {
            User current = userService.findByEmail(userDetails.getUsername()).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));
            userService.updatePassword(current.getId(), request);
            return ResponseEntity.ok().build();

        } catch (ResponseStatusException e) {
            return ResponseEntity.status(e.getStatusCode())
                    .body(Map.of("message", e.getReason()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("message", "Something went wrong, please try again."));
        }
    }
}