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
        message.setBody(buildVerificationEmail(code));

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
        message.setBody(buildVerificationEmail(code));

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

    public String buildVerificationEmail(String code) {
        return """
            tml>
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
                    We have sent you a verification code.<br>
                    If you did not request this, you can ignore this email.
                    </p>

                    <!-- CODE BOX -->
                    <div style="
                    margin:20px auto;
                    display:inline-block;
                    padding:12px 22px;
                    font-size:26px;
                    letter-spacing:6px;
                    font-weight:bold;
                    background:#15151c;
                    border:1px solid rgba(181,107,255,0.5);
                    border-radius:10px;
                    color:#ffffff;
                    min-width:200px;
                    ">
                    """ + code + """
                    </div>

                    <!-- EXPIRY -->
                    <p style="font-size:11px;color:#999999;margin-top:10px;">
                        Expires in <span style="color:#b56bff;font-weight:bold;">5 minutes</span>
                    </p>

                    </div>

                    <!-- FOOTER -->
                    <p style="text-align:center;font-size:10px;color:#555;margin-top:15px;">
                    © AURA GAMES — All rights reserved
                    </p>

                </div>

                </body>
            </html>
        """;
    }
}
