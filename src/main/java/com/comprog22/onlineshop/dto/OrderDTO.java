package com.comprog22.onlineshop.dto;

import lombok.Data;

@Data
public class OrderDTO {
    private Long id;
    private String trackingCode;
    private Long userId;
    private Double totalAmount;
    private Double discountAmount;
    private Double finalAmount;
    private String status;
}
