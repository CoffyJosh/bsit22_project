package com.comprog22.onlineshop.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ProviderOptionDTO {
    private Long providerId;
    private String providerName;
}