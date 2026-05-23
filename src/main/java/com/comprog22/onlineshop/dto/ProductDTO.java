package com.comprog22.onlineshop.dto;

import lombok.Data;

@Data
public class ProductDTO {
    private Long id;
    private Long gameId;
    private String name;
    private Double price;
    private String value;
    private String status;
}
