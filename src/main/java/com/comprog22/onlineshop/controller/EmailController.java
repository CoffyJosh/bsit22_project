package com.comprog22.onlineshop.controller;

import org.springframework.web.bind.annotation.RestController;

import com.comprog22.onlineshop.model.EmailMessage;
import com.comprog22.onlineshop.services.EmailService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequestMapping("/mail")
public class EmailController {
    private final EmailService emailService;

    public EmailController(EmailService emailService){
        this.emailService = emailService;
    }

    @GetMapping("/sendMsg")
    public String sendEmail(@RequestParam String recipient) {
        EmailMessage m = new EmailMessage(recipient,
                "This is a test message",
                "This is a test message. Please ignore this email if received.\n");

        try {
            emailService.sendMail(m);
        } catch (Exception e) {
            return "Error sending mail to " + recipient + "\n" + e; 
        }
  

        return "Email sent to " + recipient;
    }


}
