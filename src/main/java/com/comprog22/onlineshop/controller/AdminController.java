package com.comprog22.onlineshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @GetMapping("")
    public String adminRoot() {
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("pageTitle", "DASHBOARD");
        model.addAttribute("pageFragment", "admin/dashboard");
        return "admin/admin";
    }

    @GetMapping("/products")
    public String products(Model model) {
        model.addAttribute("pageTitle", "PRODUCTS");
        model.addAttribute("pageFragment", "admin/products");
        return "admin/admin";
    }

    @GetMapping("/transactions")
    public String orders(Model model) {
        model.addAttribute("pageTitle", "TRANSACTIONS");
        model.addAttribute("pageFragment", "admin/transactions");
        return "admin/admin";
    }
}