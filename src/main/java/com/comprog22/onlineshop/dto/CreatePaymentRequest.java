package com.comprog22.onlineshop.dto;

import java.math.BigDecimal;
import lombok.Data;

@Data
public class CreatePaymentRequest {
    private Long orderId;
    private String paymentMethod;
    private BigDecimal amount;
}