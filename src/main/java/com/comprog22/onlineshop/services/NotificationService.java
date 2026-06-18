package com.comprog22.onlineshop.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.model.EmailMessage;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationService {

    private final EmailService emailService;

    // Future: inject SmsService here
    // @Autowired
    // private SmsService smsService;

    /**
     * Sends a verification code to the target.
     * Automatically detects whether target is an email or phone number.
     *
     * @param target email address or phone number (e.g. "+639123456789")
     * @param code   the 6-digit verification code
     * @throws Exception if sending fails (let caller handle it)
     */
    public void send(String target, String code) throws Exception {
        if (isEmail(target)) {
            sendEmail(target, code);
        } else if (isPhone(target)) {
            sendSms(target, code);
        } else {
            throw new IllegalArgumentException("Unknown target format: " + target);
        }
    }

    // ------------------------
    // TYPE DETECTION
    // ------------------------

    private boolean isEmail(String target) {
        return target != null && target.contains("@");
    }

    private boolean isPhone(String target) {
        // accepts +639XXXXXXXXX or 09XXXXXXXXX
        return target != null && target.matches("^(\\+63|0)9\\d{9}$");
    }

    // ------------------------
    // SENDERS
    // ------------------------

    private void sendEmail(String recipient, String code) throws Exception {
        EmailMessage message = new EmailMessage();
        message.setRecipient(recipient);
        message.setSubject("AURA GAMES - Verification Code");
        message.setBody(buildVerificationEmail(code));
        emailService.sendMail(message);
    }

    private void sendSms(String target, String code) throws Exception {
        // TODO: wire up Twilio or any SMS provider here
        // Example with Twilio:
        // twilioService.send(target, "Your AURA GAMES code: " + code);

        System.out.println("📱 SMS to " + target + " → code: " + code);

        //throw new UnsupportedOperationException("SMS sending not yet implemented");
    }

    // ------------------------
    // EMAIL TEMPLATE
    // ------------------------

    private String buildVerificationEmail(String code) {
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