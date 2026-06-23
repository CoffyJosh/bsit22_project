package com.comprog22.onlineshop.services;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.security.SecureRandom;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;
import java.util.TreeMap;
import java.util.stream.Collectors;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.comprog22.onlineshop.dto.CreateOrderRequest;
import com.comprog22.onlineshop.dto.DashboardMetricsDto;
import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.OrderItem;
import com.comprog22.onlineshop.entities.TopupPackage;
import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.entities.Voucher;
import com.comprog22.onlineshop.enums.OrderStatus;
import com.comprog22.onlineshop.repository.OrderItemRepo;
import com.comprog22.onlineshop.repository.OrderRepo;
import com.comprog22.onlineshop.utils.Mathf;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepo orderRepo;
    private final OrderItemRepo orderItemRepo;
    private final TopupPackageService topupPackageService;
    private final VoucherService voucherService;
    private final UserService userService;

    @Transactional
    public Order createOrder(CreateOrderRequest request) {
        // Load package
        TopupPackage pkg = topupPackageService
                .findById(request.getPackageId())
                .orElseThrow(() -> new RuntimeException("Package not found"));

        // Load + validate voucher (single)
        Voucher voucher = null;
        if (request.getVoucherCode() != null && !request.getVoucherCode().isBlank()) {
            voucher = voucherService.getValidVoucher(request.getVoucherCode());
        }


        // Compute pricing
        BigDecimal quantity = BigDecimal.valueOf(request.getQuantity());
        BigDecimal total = pkg.getPrice().multiply(quantity);
        BigDecimal discount = voucher != null ? calculateDiscount(total, voucher) : BigDecimal.ZERO;
        discount = Mathf.clamp(discount, BigDecimal.ZERO, total);
        BigDecimal finalAmount = total.subtract(discount);

        // Check if user exists
        User user = null;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !(auth instanceof AnonymousAuthenticationToken)) {
            user = userService.findByEmail(auth.getName()).orElseThrow();
        }

        // Create ORDER
        Order order = new Order();
        order.setUser(user);
        order.setVoucher(voucher); // set on order
        order.setTrackingCode(generateTrackingCode());
        order.setTotalAmount(total);
        order.setDiscountAmount(discount);
        order.setFinalAmount(finalAmount);
        order.setStatus(OrderStatus.PENDING);

        order = orderRepo.save(order);

        // Validation of Account Id
        if (request.getAccountId() == null || request.getAccountId().isBlank()) {
            throw new RuntimeException("Account ID is required for topup");
        }

        // Create ORDER ITEM
        OrderItem item = new OrderItem();
        item.setOrder(order);
        item.setTopupPackage(pkg);
        item.setQuantity(request.getQuantity());
        item.setPrice(pkg.getPrice());
        item.setAccountId(request.getAccountId());
        item.setServer(request.getServer());

        orderItemRepo.save(item);

        return order;
    }
  
    public List<DashboardMetricsDto> getRecentMonthlyMetrics(LocalDate startDateParam, LocalDate endDateParam) {
        LocalDateTime startDateTime = startDateParam.atStartOfDay(); 
        LocalDateTime endDateTime = endDateParam.atTime(LocalTime.MAX);
        List<Order> completedOrders = orderRepo.findByCreatedAtBetweenAndStatus(startDateTime, endDateTime, OrderStatus.COMPLETED);

        // Initialize a TreeMap to guarantee chronological tracking across years
        Map<String, List<Order>> groupedByMonth = new TreeMap<>();

        // Pre-populate the map with empty arrays for every month between YOUR date ranges
        LocalDateTime currentCursor = startDateTime.withDayOfMonth(1);
        while (!currentCursor.isAfter(endDateTime)) {
            String sortableKey = String.format("%d-%02d", currentCursor.getYear(), currentCursor.getMonthValue());
            groupedByMonth.put(sortableKey, new ArrayList<>()); // Fills map with empty bucket lines
            currentCursor = currentCursor.plusMonths(1);
        }

        // Append database entities into their matching pre-populated sortable buckets
        for (Order order : completedOrders) {
            int year = order.getCreatedAt().getYear();
            int month = order.getCreatedAt().getMonthValue();
            String sortableKey = String.format("%d-%02d", year, month);

            if (groupedByMonth.containsKey(sortableKey)) {
                groupedByMonth.get(sortableKey).add(order);
            }
        }

        // Extract metrics and map safely to Lombok DTOs without dropping empty months
        List<DashboardMetricsDto> metricsList = new ArrayList<>();
        DateTimeFormatter uiFormatter = DateTimeFormatter.ofPattern("MMM yyyy", Locale.ENGLISH);

        for (Map.Entry<String, List<Order>> entry : groupedByMonth.entrySet()) {
            String sortableKey = entry.getKey(); // e.g., "2025-09"
            List<Order> ordersInMonth = entry.getValue();

            java.time.YearMonth yearMonth = java.time.YearMonth.parse(sortableKey);
            String monthLabel = yearMonth.format(uiFormatter); // Becomes "Sep 2025"

            long count = ordersInMonth.size();

            BigDecimal earnings = ordersInMonth.stream()
                    .map(Order::getFinalAmount) // <-- Check this field name!
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            BigDecimal totalRevenue = ordersInMonth.stream()
                    .map(Order::getTotalAmount) // <-- Check this field name!
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            DashboardMetricsDto metric = new DashboardMetricsDto();
            metric.setMonthLabel(monthLabel);
            metric.setTransactionCount(count);
            metric.setEarnings(earnings);
            metric.setTotalRevenue(totalRevenue);

            metricsList.add(metric);
        }

        return metricsList;
    }

    public Optional<Order> findById(Long id) {
        return orderRepo.findById(id);
    }

    public Optional<Order> findByTrackingCode(String code) {
        return orderRepo.findByTrackingCode(code);
    }

    public List<Order> getByUser(User user) {
        return orderRepo.findByUser(user);
    }

    public List<Order> getByStatus(OrderStatus status) {
        return orderRepo.findByStatus(status);
    }

    public Order updateStatus(Long id, OrderStatus status) {
        Order order = orderRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        order.setStatus(status);
        return orderRepo.save(order);
    }



    // Helpers
    private static final String CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    public String generateTrackingCode() {
        String code;
        SecureRandom random = new SecureRandom();
        do {
            StringBuilder sb = new StringBuilder("ORD-");

            for (int i = 0; i < 10; i++) {
                sb.append(CHARS.charAt(random.nextInt(CHARS.length())));
            }

            code = sb.toString();
        } while (orderRepo.existsByTrackingCode(code));

        return code;
    }

    private BigDecimal calculateDiscount(BigDecimal total, Voucher voucher) {
        if (voucher == null)
            return BigDecimal.ZERO;

        return switch (voucher.getType()) {
            case PERCENT -> total.multiply(voucher.getDiscountValue()).divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);
            case FIXED -> voucher.getDiscountValue();
        };
    }
}
