package com.comprog22.onlineshop.dto;

import lombok.Data;

@Data
public class OrderItemCreateDTO {
    private Long productId;
    private Integer quantity;
}
