package com.comprog22.onlineshop.model;

import lombok.Data;

@Data
public class EmailMessage {
    private String recipient;
    private String subject;
    private String body;
}
