package com.comprog22.onlineshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
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

    @PostMapping("/register")
    public User postDetails(@RequestBody User user) {
        String hash = PasswordUtil.hash(user.getPassword());
        user.setPassword(hash);
        return userService.register(user);
    }
}
