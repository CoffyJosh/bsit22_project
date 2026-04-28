package com.comprog22.onlineshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.comprog22.onlineshop.model.Student;
import com.comprog22.onlineshop.services.EmailService;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
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
    
