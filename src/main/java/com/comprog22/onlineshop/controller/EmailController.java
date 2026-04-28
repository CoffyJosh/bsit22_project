package com.comprog22.onlineshop.controller;

import org.springframework.web.bind.annotation.RestController;

import com.comprog22.onlineshop.model.EmailMessage;
import com.comprog22.onlineshop.services.EmailService;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/mail")
public class EmailController {
    private final EmailService emailService;

    public EmailController(EmailService emailService){
        this.emailService = emailService;
    }

    @PostMapping("/sendMsg")
    public String sendEmail(@RequestBody EmailMessage m) {
        try {
            emailService.sendMail(m);
        } catch (Exception e) {
            return "Error sending mail to " + m.getRecipient() + "\n" + e; 
        }
  
        return "Email sent to " + m.getRecipient();
    }

}
