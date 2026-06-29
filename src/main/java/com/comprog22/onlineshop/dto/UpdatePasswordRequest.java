package com.comprog22.onlineshop.dto;

import lombok.Data;

@Data
public class UpdatePasswordRequest {
    private String currentPassword;
    private String newPassword;
}