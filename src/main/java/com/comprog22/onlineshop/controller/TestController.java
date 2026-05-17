package com.comprog22.onlineshop.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class TestController {
    
    @GetMapping("/helloWorld")
    public String getMethodName() {
        return "Hello World my Niggas!";
    }

    @GetMapping("/testing/hello")
    public String helloPage(@RequestParam(name = "name") String name){
        return "Hello " + name;
    }
}
    
