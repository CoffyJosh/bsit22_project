package com.comprog22.onlineshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@RestController
public class TestController {
    
    @GetMapping("/helloWorld")
    public String getMethodName() {
        return "Hello World my Niggas!";
    }

    @RequestMapping("/")
    public String index() {
        return "index.html";
    }
    
  
}
    
