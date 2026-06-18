package com.comprog22.onlineshop.services;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.VerificationCode;
import com.comprog22.onlineshop.repository.VerificationCodeRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class VerificationCodeService {

    private final VerificationCodeRepo verificationCodeRepository;
    private final NotificationService notificationService; 

    public String sendCode(String recipient, String purpose) {

        Optional<VerificationCode> existing = verificationCodeRepository.findByRecipientAndPurpose(recipient, purpose);

        if (existing.isPresent()) {
            VerificationCode vc = existing.get();

            // active + still in cooldown → tell frontend to just show confirmation
            if (!vc.isExpired() && !vc.canResend()) {
                return "ALREADY_SENT:" + vc.secondsUntilResend();
            }

            // active + cooldown passed → still valid, let them use it
            if (!vc.isExpired()) {
                return "ALREADY_SENT:0";
            }

            // expired → delete and send fresh
            verificationCodeRepository.deleteByRecipientAndPurpose(recipient, purpose);
        }

        // generate new 6-digit code
        String code = String.format("%06d", new Random().nextInt(999999));

        VerificationCode vc = new VerificationCode();
        vc.setRecipient(recipient);
        vc.setCode(code);
        vc.setPurpose(purpose);

        verificationCodeRepository.save(vc);

        try {
            notificationService.send(recipient, code);
        } catch (Exception e) {
            System.out.println(e);
            return "SEND_FAILED";
        }

        return "SENT";
    }

    public String resendCode(String recipient, String purpose) {

        Optional<VerificationCode> existing = verificationCodeRepository.findByRecipientAndPurpose(recipient, purpose);

        // no existing code, send fresh
        if (existing.isEmpty()) {
            return sendCode(recipient, purpose);
        }

        VerificationCode vc = existing.get();

        // still in cooldown
        if (!vc.canResend()) {
            return "COOLDOWN:" + vc.secondsUntilResend();
        }

        // generate new code and extend expiry
        String code = String.format("%06d", new Random().nextInt(999999));
        vc.setCode(code);
        vc.setExpiresAt(LocalDateTime.now().plusMinutes(5));
        vc.setResendAvailableAt(LocalDateTime.now().plusMinutes(1));

        verificationCodeRepository.save(vc);

        try {
            notificationService.send(recipient, code);
        } catch (Exception e) {
            System.out.println(e);
            return "SEND_FAILED";
        }

        return "SENT";
    }

    public String verifyCode(String recipient, String code, String purpose) {

        Optional<VerificationCode> existing = verificationCodeRepository.findByRecipientAndPurpose(recipient, purpose);

        if (existing.isEmpty()) {
            System.out.println("\n\n\nNOT FOUND\n\n\n");
            return "NOT_FOUND";
        }

        VerificationCode vc = existing.get();

        if (vc.isExpired()) {
            verificationCodeRepository.deleteByRecipientAndPurpose(recipient, purpose);
            System.out.println("\n\n\nEXPIRED\n\n\n");
            return "EXPIRED";
        }

        if (!vc.getCode().equals(code)) {
            System.out.println("\n\n\nINVALID\n\n\n");
            return "INVALID";
        }

        verificationCodeRepository.deleteByRecipientAndPurpose(recipient, purpose);
        System.out.println("\n\n\nVALID\n\n\n");
        return "VALID";
    }

    public long getResendCooldown(String recipient, String purpose) {
        Optional<VerificationCode> existing = verificationCodeRepository.findByRecipientAndPurpose(recipient, purpose);
        if (existing.isEmpty() || existing.get().canResend())
            return 0;
        return existing.get().secondsUntilResend();
    }

    public void completeVerification(String recipient, String purpose) {
        verificationCodeRepository.deleteByRecipientAndPurpose(recipient, purpose);
    }
}