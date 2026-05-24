package com.comprog22.onlineshop.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.comprog22.onlineshop.model.EmailMessage;
import com.comprog22.onlineshop.services.EmailService;

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
            System.out.println("Attempting to send email to: " + m.getRecipient());
            emailService.sendMail(m);
            System.out.println("Email sent successfully");
        } catch (Exception e) {
            System.out.println("Email failed: " + e);
            return "EMAIL_FAILED";
        }
  
        return "Email sent to " + m.getRecipient();
    }

}
