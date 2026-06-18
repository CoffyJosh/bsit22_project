package com.comprog22.onlineshop.dto;

import lombok.Data;


@Data
public class CreateUserChangeRequest {
    private Long id;
    private String email;
    private String password;
    private String name;
}
