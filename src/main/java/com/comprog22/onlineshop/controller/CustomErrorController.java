package com.comprog22.onlineshop.controller;

import org.springframework.boot.webmvc.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        Object status = request.getAttribute("jakarta.servlet.error.status_code");

        String message = "Something went wrong.";
        if (status != null && status.equals(404)) {
            message = "This page doesn't exist.";
        }

        model.addAttribute("message", message);
        return "error";
    }
}