package com.comprog22.onlineshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.services.UserService;


@RestController
public class TestController {

    @Autowired
    private UserService userService;
    
    @GetMapping("/helloWorld")
    public String getMethodName() {
        return "Hello World my Niggas!";
    }

    @GetMapping("/testing/hello")
    public String helloPage(@RequestParam(name = "name") String name){
        return "Hello " + name;
    }

    @GetMapping("/testing/getUser")
    public User getUser(@RequestParam(name = "email") String email) {
        return userService.getUserInfoByEmail(email).orElseThrow();
    }
}
    
