package com.comprog22.onlineshop.controller;

import com.comprog22.onlineshop.dto.DashboardMetricsDto;
import com.comprog22.onlineshop.services.OrderService;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/admin/dashboard")
public class DashboardApiController {

    private final OrderService orderService;

    // Standard constructor injection hooking directly into your OrderService
    public DashboardApiController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/metrics")
    public List<DashboardMetricsDto> getChartData(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        return orderService.getRecentMonthlyMetrics(startDate, endDate);
    }
}