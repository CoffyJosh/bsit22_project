package com.comprog22.onlineshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.services.AuthService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.comprog22.onlineshop.services.UserService;
import com.comprog22.onlineshop.services.VerificationCodeService;


@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @Autowired
    private UserService userService;

    @Autowired
    private VerificationCodeService verificationCodeService;

    @PostMapping(value = "/register", consumes = "application/json")
    public User register(@RequestBody User user) {
        return authService.register(user);
    }

    @GetMapping("/check-username")
    @ResponseBody
    public boolean checkUsername(@RequestParam String name) {
        return userService.existsByName(name);
    }


    @GetMapping("/check-email")
    @ResponseBody
    public boolean checkEmail(@RequestParam String email){
        return userService.existsByEmail(email);
    }

    @PostMapping("/send-code")
    public ResponseEntity<String> sendCode(@RequestParam String email, @RequestParam String purpose) {

        String result = verificationCodeService.sendCode(email, purpose);

        return switch (result) {
            case "SENT" -> ResponseEntity.ok("Code sent");
            case "COOLDOWN" -> ResponseEntity.status(429).body("Please wait before requesting a new code");
            case "EMAIL_FAILED" -> ResponseEntity.status(500).body("Failed to send email");
            default -> ResponseEntity.status(500).body("Something went wrong");
        };
    }

    @PostMapping("/resend-code")
    public ResponseEntity<String> resendCode(@RequestParam String email, @RequestParam String purpose) {

        String result = verificationCodeService.resendCode(email, purpose);

        if (result.startsWith("COOLDOWN:")) {
            String seconds = result.split(":")[1];
            return ResponseEntity.status(429).body(seconds);
        }

        return switch (result) {
            case "SENT" -> ResponseEntity.ok("Code resent");
            case "EMAIL_FAILED" -> ResponseEntity.status(500).body("Failed to send email");
            default -> ResponseEntity.status(500).body("Something went wrong");
        };
    }

    @PostMapping("/verify-code")
    public ResponseEntity<String> verifyCode(@RequestParam String email, @RequestParam String code, @RequestParam String purpose) {

        String result = verificationCodeService.verifyCode(email, code, purpose);

        return switch (result) {
            case "VALID" -> ResponseEntity.ok("Valid");
            case "INVALID" -> ResponseEntity.status(400).body("Invalid code");
            case "EXPIRED" -> ResponseEntity.status(410).body("Code expired");
            case "NOT_FOUND" -> ResponseEntity.status(404).body("No code found");
            default -> ResponseEntity.status(500).body("Something went wrong");
        };
    }

    @GetMapping("/resend-cooldown")
    public ResponseEntity<Long> getResendCooldown(@RequestParam String email, @RequestParam String purpose) {
        long seconds = verificationCodeService.getResendCooldown(email, purpose);
        return ResponseEntity.ok(seconds);
    }

    @PostMapping("/complete-verification")
    public ResponseEntity<?> completeVerification(
            @RequestParam String email,
            @RequestParam String purpose) {
        verificationCodeService.completeVerification(email, purpose);
        return ResponseEntity.ok().build();
    }
}