package com.comprog22.onlineshop.dto;

import lombok.Data;

@Data
public class PaymentDTO {
    private Long id;
    private Long orderId;
    private String paymentMethod;
    private Double amount;
    private String transactionReference;
    private String status;
}
