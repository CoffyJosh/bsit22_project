package com.comprog22.onlineshop.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GameDetailDTO {
    private Long id;
    private String name;
    private String packageName;
    private String status;
    private LocalDateTime createdAt;

    private Long providerId;
    private Long providerProductId;

    private boolean hasIcon;
    private boolean hasThumbnail;
    private boolean hasBanner;
    private boolean hasPackageImage;

    private Long totalSales;
    private BigDecimal revenue;
    private Integer packagesCount;
}