package com.comprog22.onlineshop.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailsDTO {

    // Transaction Details
    private String trackingCode;
    private String status;
    private LocalDateTime createdAt;
    private String gameName;
    private Long gameId;
    private BigDecimal amountPaid;
    private String paymentMethod;

    // Order Description
    private String packageName;
    private BigDecimal packageAmount;
    private BigDecimal packagePrice;

    private String voucherCode;
    private BigDecimal discountValue;
    private String discountType;

    // Customer Details
    private String username;
    private String email;
    private String accountId;
}