package com.comprog22.onlineshop.repository;

import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.comprog22.onlineshop.entities.VerificationCode;

@Repository
public interface VerificationCodeRepo extends JpaRepository<VerificationCode, Long> {
    Optional<VerificationCode> findByEmailAndPurpose(String email, String purpose);

    Optional<VerificationCode> findTopByEmailAndPurposeAndExpiresAtAfterOrderByCreatedAtDesc(
        String email,
        String purpose,
        LocalDateTime now
    );
    
    @Transactional
    void deleteByEmailAndPurpose(String email, String purpose);
}