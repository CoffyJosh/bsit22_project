package com.comprog22.onlineshop.dto;

import lombok.Data;

@Data
public class OrderCreateDTO {
    private Long userId;
    private Long voucherId;
}
