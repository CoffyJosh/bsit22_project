package com.comprog22.onlineshop.services;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.comprog22.onlineshop.entities.Token;
import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.repository.TokenRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TokenService {

    private final TokenRepository tokenRepository;
    private final UserService userService;

    @Transactional
    public String createToken(String email, String purpose) {

        LocalDateTime now = LocalDateTime.now();

        Token token = tokenRepository.findByEmailAndPurpose(email, purpose).orElse(null);

        // CASE 1: no token exists
        if (token == null) {
            return createNewToken(email, purpose);
        }

        // CASE 2: RESEND COOLDOWN ACTIVE
        if (token.getResendAvailableAt() != null &&
                now.isBefore(token.getResendAvailableAt())) {
            return token.getToken();
        }

        // CASE 3: TOKEN EXISTS AND NOT EXPIRED → reuse, but update resend timer
        if (!token.isExpired()) {
            token.setResendAvailableAt(now.plusMinutes(1));
            tokenRepository.save(token);
            return token.getToken();
        }

        // CASE 4: EXPIRED, rotate token
        token.setToken(UUID.randomUUID().toString());
        token.setCreatedAt(now);
        token.setExpiresAt(now.plusMinutes(30));
        token.setResendAvailableAt(now.plusMinutes(1));

        tokenRepository.save(token);

        return token.getToken();
    }

    public String createNewToken(String email, String purpose) {
        User user = userService.findByEmail(email).orElseThrow();

        Token t = new Token();
        t.setEmail(email);
        t.setUser(user);
        t.setToken(UUID.randomUUID().toString());
        t.setPurpose(purpose);

        tokenRepository.save(t);
        return t.getToken();
    }

    public Token validateToken(String tokenStr) {
        Token t = tokenRepository.findByToken(tokenStr)
                .orElseThrow(() -> new IllegalArgumentException("Invalid or already used token"));

        if (t.isExpired()) {
            throw new IllegalStateException("Token expired");
        }

        return t;
    }

    public void markUsed(Token token) {
        tokenRepository.delete(token);
    }
}