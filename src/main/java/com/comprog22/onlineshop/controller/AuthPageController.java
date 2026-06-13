package com.comprog22.onlineshop.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class AuthPageController {

    @RequestMapping("/index")
    public String index() {
        return "index";
    }

    @GetMapping("/login")
    public String login(Authentication auth, Model model, @RequestHeader(value = "HX-Request", required = false) String htmxRequest, HttpServletResponse response) {
        if (auth != null && auth.isAuthenticated()) {
            return "redirect:/";
        }

        if (htmxRequest != null) {
            response.setHeader("HX-Title", "AURA GAMES | Login");
            return "auth/login :: content"; // just the fragment for HTMX swaps
        }

        model.addAttribute("view", "auth/login");
        return "auth/auth"; // full page for direct URL visits
    }

    @GetMapping("/register")
    public String register(Authentication auth, Model model, @RequestHeader(value = "HX-Request", required = false) String htmxRequest, HttpServletResponse response) {
        if (auth != null && auth.isAuthenticated()) {
            return "redirect:/";
        }

        if (htmxRequest != null) {
            response.setHeader("HX-Title", "Aura Games - Register");
            return "auth/register :: content";
        }

        model.addAttribute("view", "auth/register");
        return "auth/auth";
    }

    @GetMapping("/account-recovery")
    public String accountRecovery(Authentication auth, Model model, @RequestHeader(value = "HX-Request", required = false) String htmxRequest, HttpServletResponse response) {
        if (auth != null && auth.isAuthenticated()) {
            return "redirect:/";
        }

        if (htmxRequest != null) {
            response.setHeader("HX-Title", "Aura Games - Recovery");
            return "auth/account-recovery :: content";
        }

        model.addAttribute("view", "auth/account-recovery");
        return "auth/auth";
    }
}