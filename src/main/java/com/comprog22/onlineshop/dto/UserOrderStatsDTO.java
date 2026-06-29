package com.comprog22.onlineshop.dto;

import java.math.BigDecimal;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UserOrderStatsDTO {
    private Long transactionCount;
    private BigDecimal totalSpent;
    private Long vouchersUsed;
}