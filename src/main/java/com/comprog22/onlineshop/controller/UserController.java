package com.comprog22.onlineshop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.RestController;

import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.services.UserService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.comprog22.onlineshop.utils.PasswordUtil;


@RestController
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/register")
    public User postDetails(@RequestBody User user) {

        if (user.getPassword() != null)
            user.setPassword(passwordEncoder.encode(user.getPassword()));

        return userService.register(user);
    }

    @PostMapping("/register/batch")
    public List<User> postDetails(@RequestBody List<User> users) {
        for (User u : users){
            if (u.getPassword() != null)
                u.setPassword(PasswordUtil.hash(u.getPassword()));
        }

        return userService.registerBatch(users);
    }
}
