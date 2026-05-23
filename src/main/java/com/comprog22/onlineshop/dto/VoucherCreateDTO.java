package com.comprog22.onlineshop.dto;

import lombok.Data;

@Data
public class VoucherCreateDTO {
    private Long productId;
    private String code;
    private Double discountValue;
    private Integer usageLimit;
    private String type;
    private String expirationDate;
}