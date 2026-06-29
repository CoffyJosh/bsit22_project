package com.comprog22.onlineshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserPageController {
    @GetMapping("")
    public String adminRoot() {
        return "redirect:/user/overview";
    }

    @GetMapping("/overview")
    public String dashboard(Model model) {
        model.addAttribute("pageTitle", "OVERVIEW");
        model.addAttribute("pageFragment", "user/overview");
        return "user/user";
    }

    @GetMapping("/settings")
    public String products(Model model) {
        model.addAttribute("pageTitle", "SETTINGS");
        model.addAttribute("pageFragment", "user/settings");
        return "user/user";
    }
}