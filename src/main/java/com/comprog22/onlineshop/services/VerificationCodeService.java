package com.comprog22.onlineshop.services;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.VerificationCode;
import com.comprog22.onlineshop.model.EmailMessage;
import com.comprog22.onlineshop.repository.VerificationCodeRepo;

@Service
public class VerificationCodeService {

    @Autowired
    private VerificationCodeRepo verificationCodeRepository;

    @Autowired
    private EmailService emailService;

    public String sendCode(String email, String purpose) {

        Optional<VerificationCode> existing = verificationCodeRepository.findByEmailAndPurpose(email, purpose);

        // if code exists and cooldown hasn't passed, reject
        if (existing.isPresent() && !existing.get().canResend()) {
            return "COOLDOWN";
        }

        // delete old code if exists and is expired
        if (existing.isPresent()) {
            VerificationCode vc = existing.get();

            // if NOT expired → block new code
            if (!vc.isExpired()) {
                return "ACTIVE_CODE_EXISTS";
            }

            // expired → safe to replace
            verificationCodeRepository.deleteByEmailAndPurpose(email, purpose);
        }

        // generate new 6 digit code
        String code = String.format("%06d", new Random().nextInt(999999));

        VerificationCode vc = new VerificationCode();
        vc.setEmail(email);
        vc.setCode(code);
        vc.setPurpose(purpose);

        verificationCodeRepository.save(vc);

        // send email
        EmailMessage message = new EmailMessage();
        message.setRecipient(email);
        message.setSubject("AURA GAMES - Verification Code");
        message.setBody("Your verification code is: " + code + "\n\nThis code expires in 5 minutes.");

        try {
            emailService.sendMail(message);
        } catch (Exception e) {
            System.out.println(e);
            return "EMAIL_FAILED";
        }

        return "SENT";
    }

    public String resendCode(String email, String purpose) {

        Optional<VerificationCode> existing = verificationCodeRepository.findByEmailAndPurpose(email, purpose);

        // no existing code, just send fresh
        if (existing.isEmpty()) {
            return sendCode(email, purpose);
        }

        VerificationCode vc = existing.get();

        // check cooldown
        if (!vc.canResend()) {
            return "COOLDOWN:" + vc.secondsUntilResend();
        }

        // generate new code
        String code = String.format("%06d", new Random().nextInt(999999));
        vc.setCode(code);
        vc.setExpiresAt(LocalDateTime.now().plusMinutes(5));
        vc.setResendAvailableAt(LocalDateTime.now().plusMinutes(1));

        verificationCodeRepository.save(vc);

        // send email
        EmailMessage message = new EmailMessage();
        message.setRecipient(email);
        message.setSubject("AURA GAMES - Verification Code");
        message.setBody("Your new verification code is: " + code + "\n\nThis code expires in 5 minutes.");

        try {
            emailService.sendMail(message);
        } catch (Exception e) {
            System.out.println(e);
            return "EMAIL_FAILED";
        }

        return "SENT";
    }

    public String verifyCode(String email, String code, String purpose) {

        Optional<VerificationCode> existing = verificationCodeRepository.findByEmailAndPurpose(email, purpose);

        if (existing.isEmpty()){
            System.out.println("\n\n\nNOT FOUND\n\n\n");
            return "NOT_FOUND";
        }


        VerificationCode vc = existing.get();

        // check expiry
        if (vc.isExpired()) {
            verificationCodeRepository.deleteByEmailAndPurpose(email, purpose);
            System.out.println("\n\n\nEXPIRED\n\n\n");
            return "EXPIRED";
        }

        // check code matches
        if (!vc.getCode().equals(code)){
            System.out.println("\n\n\nINVALID\n\n\n");
            return "INVALID";
        }    

        // valid — delete so it cant be reused
        verificationCodeRepository.deleteByEmailAndPurpose(email, purpose);
        System.out.println("\n\n\nVALID\n\n\n");
        return "VALID";
    }

    public long getResendCooldown(String email, String purpose) {
        Optional<VerificationCode> existing = verificationCodeRepository.findByEmailAndPurpose(email, purpose);
        if (existing.isEmpty() || existing.get().canResend()) return 0;
        return existing.get().secondsUntilResend();
    }

    public void completeVerification(String email, String purpose){
        verificationCodeRepository.deleteByEmailAndPurpose(email, purpose);
    }
}
