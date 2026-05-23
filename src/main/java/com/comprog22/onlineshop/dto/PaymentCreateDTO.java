package com.comprog22.onlineshop.dto;

import lombok.Data;

@Data
public class PaymentCreateDTO {
    private Long orderId;
    private String paymentMethod;
    private Double amount;
}