package com.comprog22.onlineshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class StoreController {

    @GetMapping({ "/", "/home" })
    public String requestMethodName() {
        return "home";
    }  
}
