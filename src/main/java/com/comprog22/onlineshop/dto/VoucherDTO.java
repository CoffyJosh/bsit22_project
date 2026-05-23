package com.comprog22.onlineshop.dto;

import lombok.Data;

@Data
public class VoucherDTO {
    private Long id;
    private Long productId;
    private String code;
    private Double discountValue;
    private Integer usageLimit;
    private Integer usedCount;
    private String type;
    private String status;
    private String expirationDate;
}