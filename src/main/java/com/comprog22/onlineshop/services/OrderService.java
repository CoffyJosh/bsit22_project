package com.comprog22.onlineshop.services;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.security.SecureRandom;
import java.util.List;
import java.util.Optional;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.comprog22.onlineshop.dto.CreateOrderRequest;
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
