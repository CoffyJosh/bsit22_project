package com.comprog22.onlineshop.entities;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Data;

@Entity
@Table(uniqueConstraints = @UniqueConstraint(columnNames = {"email", "purpose"}))
@Data
public class VerificationCode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String email;
    private String code;
    private String purpose;

    @CreationTimestamp
    private LocalDateTime createdAt;

    private LocalDateTime expiresAt;
    private LocalDateTime resendAvailableAt;

    @PrePersist
    public void onPersist() {
        this.expiresAt = LocalDateTime.now().plusMinutes(5);
        this.resendAvailableAt = LocalDateTime.now(); // ← was .plusMinutes(1)
    }

    public boolean isExpired() {
        return LocalDateTime.now().isAfter(expiresAt);
    }

    public boolean canResend() {
        return LocalDateTime.now().isAfter(resendAvailableAt);
    }

    public long secondsUntilResend() {
        if (canResend())
            return 0;
        return ChronoUnit.SECONDS.between(LocalDateTime.now(), resendAvailableAt);
    }
}