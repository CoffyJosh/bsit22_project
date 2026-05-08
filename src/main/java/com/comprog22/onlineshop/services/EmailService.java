package com.comprog22.onlineshop.services;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.model.EmailMessage;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {

    private static final String EMAIL = "OnlySchools1738@gmail.com";
    private static final String PASS = "utoi gket anyg mwtx";

    public void sendMail(EmailMessage emailMessage) throws Exception {
        Message msg = new MimeMessage(getEmailSession());
        msg.setFrom(new InternetAddress(EMAIL));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailMessage.getRecipient()));
        msg.setSubject(emailMessage.getSubject());
        msg.setText(emailMessage.getBody());
        Transport.send(msg);
    }

    private Session getEmailSession(){
        Authenticator auth = new Authenticator(){
            @Override
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(EMAIL, PASS);
            }
        };

        return Session.getInstance(getGmailProperties(), auth);
    }

    private Properties getGmailProperties(){
        Properties prop = new Properties();
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        return prop;
    }
}
