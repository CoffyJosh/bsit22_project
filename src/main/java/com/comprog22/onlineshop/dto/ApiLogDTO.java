package com.comprog22.onlineshop.dto;

import lombok.Data;

@Data
public class ApiLogDTO {
    private Long id;
    private Long orderId;
    private String requestPayload;
    private String responsePayload;
    private String status;
    private String createdAt;
}