package com.comprog22.onlineshop.dto;

import lombok.Data;

@Data
public class CreateOrderRequest {
    private Long packageId;
    private Integer quantity;
    private String voucherCode;
    private String accountId;
    private String server;
    private String email;
}