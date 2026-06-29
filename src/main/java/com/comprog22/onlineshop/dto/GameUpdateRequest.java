package com.comprog22.onlineshop.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class GameUpdateRequest {
    private String name;
    private String packageName;
    private String status;
    private Long providerId;
    private String productCode;
    private MultipartFile icon;
    private MultipartFile thumbnail;
    private MultipartFile banner;
    private MultipartFile packageImage;
}
