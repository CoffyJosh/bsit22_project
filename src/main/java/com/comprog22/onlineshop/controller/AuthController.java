package com.comprog22.onlineshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.services.AuthService;
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
    public ResponseEntity<?> sendCode(@RequestParam String recipient, @RequestParam String purpose) {

        String result = verificationCodeService.sendCode(recipient, purpose);

        if (result.startsWith("ALREADY_SENT:")) {
            String seconds = result.split(":")[1];
            return ResponseEntity.status(202).body(seconds);
        }

        return switch (result) {
            case "SENT" -> ResponseEntity.ok("Code sent");
            case "SEND_FAILED" -> ResponseEntity.status(500).body("Failed to send code");
            default -> ResponseEntity.status(500).body("Something went wrong");
        };
    }

    @PostMapping("/resend-code")
    public ResponseEntity<String> resendCode(@RequestParam String recipient, @RequestParam String purpose) {
        String result = verificationCodeService.resendCode(recipient, purpose);

        if (result.startsWith("COOLDOWN:")) {
            String seconds = result.split(":")[1];
            return ResponseEntity.status(429).body(seconds);
        }

        return switch (result) {
            case "SENT" -> ResponseEntity.ok("Code resent");
            case "SEND_FAILED" -> ResponseEntity.status(500).body("Failed to send code");
            default -> ResponseEntity.status(500).body("Something went wrong");
        };
    }

    @PostMapping("/verify-code")
    public ResponseEntity<String> verifyCode(@RequestParam String recipient, @RequestParam String code, @RequestParam String purpose) {

        String result = verificationCodeService.verifyCode(recipient, code, purpose);

        return switch (result) {
            case "VALID" -> ResponseEntity.ok("Valid");
            case "INVALID" -> ResponseEntity.status(400).body("Invalid code");
            case "EXPIRED" -> ResponseEntity.status(410).body("Code expired");
            case "NOT_FOUND" -> ResponseEntity.status(404).body("No code found");
            default -> ResponseEntity.status(500).body("Something went wrong");
        };
    }

    @GetMapping("/resend-cooldown")
    public ResponseEntity<Long> getResendCooldown(@RequestParam String recipient, @RequestParam String purpose) {
        long seconds = verificationCodeService.getResendCooldown(recipient, purpose);
        return ResponseEntity.ok(seconds);
    }

    @PostMapping("/complete-verification")
    public ResponseEntity<?> completeVerification(@RequestParam String recipient, @RequestParam String purpose) {
        verificationCodeService.completeVerification(recipient, purpose);
        return ResponseEntity.ok().build();
    }
}