package com.comprog22.onlineshop.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.comprog22.onlineshop.entities.Token;
import com.comprog22.onlineshop.model.EmailMessage;
import com.comprog22.onlineshop.services.AuthService;
import com.comprog22.onlineshop.services.EmailService;
import com.comprog22.onlineshop.services.TokenService;

import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/account-recovery")
public class AccountRecoveryController {

    private final TokenService tokenService;
    private final EmailService emailService;
    private final AuthService authService;

    @PostMapping
    public String sendResetLink(@RequestParam String email, Model model) {

        System.out.println("\n\n\nRecovery requested for: " + email + "\n\n\n");

        try {
            String token = tokenService.createToken(email, "PASSWORD_RESET");

            System.out.println("Token created: " + token);

            String link = "http://localhost:8080/account-recovery/reset?token=" + token;

            EmailMessage message = new EmailMessage();
            message.setRecipient(email);
            message.setSubject("Reset your Aura Games password");
            message.setBody(buildResetPasswordEmail(link));

            emailService.sendMail(message);

            // IMPORTANT: switch UI state
            model.addAttribute("emailSent", true);
            return "auth/account-recovery :: content";

        } catch (Exception e) {

            e.printStackTrace();

            model.addAttribute("error", e.getMessage());

            return "auth/account-recovery :: content";
        }
    }

    @GetMapping("/reset")
    public String resetPage(@RequestParam String token, Authentication auth, Model model,
            @RequestHeader(value = "HX-Request", required = false) String htmxRequest,
            HttpServletResponse response) {
        if (auth != null && auth.isAuthenticated()) {
            return "redirect:/";
        }

        try {
            Token t = tokenService.validateToken(token);
            model.addAttribute("token", t.getToken());
        } catch (Exception e) {
            return "redirect:/account-recovery";
        }

        if (htmxRequest != null) {
            response.setHeader("HX-Title", "Aura Games - Update Password");
            return "auth/update-password :: content";
        }

        model.addAttribute("view", "auth/update-password");
        return "auth/auth";
    }
    
    @ResponseBody
    @PostMapping("/update-password")
    public ResponseEntity<String> updatePassword(@RequestParam String token, @RequestParam String password) {
        try {
            Token t = tokenService.validateToken(token);
            authService.updatePassword(t.getUser().getId(), password);
            tokenService.markUsed(t);
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    
    // HELPER
    private String buildResetPasswordEmail(String link) {
        return """
                <html>
                <body style="margin:0;padding:0;background-color:#0b0b0f;font-family:Arial,sans-serif;">

                    <div style="max-width:520px;margin:25px auto;padding:15px;">

                    <!-- MAIN CARD -->
                    <div style="
                        background: linear-gradient(135deg, #3e004a 90%, #6c014c 10%);
                        border-radius:14px;
                        padding:25px;
                        text-align:center;
                        color:white;
                        box-shadow:0 0 20px rgba(106,0,255,0.2);
                    ">

                        <!-- LOGO -->
                        <img src="https://drive.google.com/uc?export=view&id=15ai6imo5mK98cAEGAs_M7iyUZy69_1G2"
                            alt="Logo"
                            style="width:150px;height:150px;margin-bottom:0px;padding:0px;" />

                        <!-- BRAND -->
                        <h1 style="margin:0;font-size:40px;letter-spacing:1.5px;padding-top:0px;">
                        <span style="color:rgb(255, 0, 149);font-weight:bold;">AURA</span>
                        <span style="color:#ffffff;font-weight:bold;">GAMES</span>
                        </h1>

                        <!-- MESSAGE -->
                        <p style="margin-top:15px;font-size:13px;color:#cccccc;line-height:1.4;">
                        We received a request to reset your password.<br>
                        If you did not request this, you can ignore this email.
                        </p>

                        <!-- RESET BUTTON -->
                        <a href="%s" style="
                        display:inline-block;
                        margin:20px auto;
                        padding:12px 28px;
                        font-size:16px;
                        font-weight:bold;
                        background:#b56bff;
                        border-radius:10px;
                        color:#ffffff;
                        text-decoration:none;
                        ">
                            Reset Password
                        </a>

                        <!-- EXPIRY -->
                        <p style="font-size:11px;color:#999999;margin-top:10px;">
                            Link expires in <span style="color:#b56bff;font-weight:bold;">30 minutes</span>
                        </p>

                        </div>

                        <!-- FOOTER -->
                        <p style="text-align:center;font-size:10px;color:#555;margin-top:15px;">
                        © AURA GAMES — All rights reserved
                        </p>

                    </div>

                    </body>
                </html>
                """.replace("%s", link);
    }
}