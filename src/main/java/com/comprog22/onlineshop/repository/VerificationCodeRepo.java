package com.comprog22.onlineshop.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.comprog22.onlineshop.entities.VerificationCode;

@Repository
public interface VerificationCodeRepo extends JpaRepository<VerificationCode, Long> {

    Optional<VerificationCode> findByRecipientAndPurpose(String target, String purpose);

    @Transactional
    void deleteByRecipientAndPurpose(String target, String purpose);
}