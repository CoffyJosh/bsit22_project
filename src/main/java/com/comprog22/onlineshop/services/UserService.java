package com.comprog22.onlineshop.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.enums.UserStatus;
import com.comprog22.onlineshop.repository.UserRepo;

@Service
public class UserService {

    @Autowired
    private UserRepo userRepo;

    public Optional<User> getUserInfoByEmail(String email){
        return userRepo.findByEmail(email);
    }

    public Optional<User> getUserInfoByID(Long id) {
        return userRepo.findById(id);
    }

    public User createUser(User user) {
        return userRepo.save(user);
    }

    public List<User> createUserByBatch(List<User> users) {
        return userRepo.saveAll(users);
    }

    public Optional<User> findById(Long id) {
        return userRepo.findById(id);
    }

    public Optional<User> findByEmail(String email) {
        return userRepo.findByEmail(email);
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
}
