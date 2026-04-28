package com.comprog22.onlineshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FormControlller {

    @RequestMapping("/home")
    public String gotoHome(){
        return "homepage.html";
    }
}
