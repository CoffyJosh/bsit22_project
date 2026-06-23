package com.comprog22.onlineshop.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin")
public class AdminPageController {

    @RequestMapping
    public String index() {
        return "admin";
    }
}