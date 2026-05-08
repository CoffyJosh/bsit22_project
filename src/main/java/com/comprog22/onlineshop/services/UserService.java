package com.comprog22.onlineshop.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.repository.UserRepo;

@Service
public class UserService {

    @Autowired
    private UserRepo userRepo;
    
    public User register(User user){
        return userRepo.save(user);
    }
}
