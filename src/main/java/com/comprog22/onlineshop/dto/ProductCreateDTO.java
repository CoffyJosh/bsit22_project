package com.comprog22.onlineshop.dto;

import lombok.Data;

@Data
public class ProductCreateDTO {
    private Long gameId;
    private Double price;
    private String value;
}
