package com.comprog22.onlineshop.dto;

import java.math.BigDecimal;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DashboardMetricsDto {
    private String monthLabel;
    private long transactionCount; 
    private BigDecimal earnings; 
    private BigDecimal totalRevenue; 
}