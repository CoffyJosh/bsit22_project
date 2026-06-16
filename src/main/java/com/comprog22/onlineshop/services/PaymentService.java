package com.comprog22.onlineshop.services;

import java.math.BigDecimal;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.Payment;
import com.comprog22.onlineshop.enums.OrderStatus;
import com.comprog22.onlineshop.enums.PaymentStatus;
import com.comprog22.onlineshop.repository.PaymentRepo;

@Service
public class PaymentService {
    private final PaymentRepo paymentRepo;
    private final OrderService orderService;
    private final VoucherService voucherService;

    private static final String CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    public PaymentService(PaymentRepo paymentRepo, OrderService orderService, VoucherService voucherService) {
        this.paymentRepo = paymentRepo;
        this.orderService = orderService;
        this.voucherService = voucherService;
    }

    @Transactional
    public Payment createPayment(Order order, String paymentMethod, BigDecimal amount) {
        Payment payment = new Payment();
        payment.setOrder(order);
        payment.setPaymentMethod(paymentMethod);
        payment.setAmount(amount);
        payment.setTransactionReference(generateTransactionReference());
        payment.setStatus(PaymentStatus.SUCCESS);
        payment.setPaidAt(LocalDateTime.now());

        if (order.getVoucher() != null) {
            voucherService.incrementUsage(order.getVoucher());
        }

        orderService.updateStatus(order.getId(), OrderStatus.COMPLETED);

        return paymentRepo.save(payment);
    }

    private String generateTransactionReference() {
        SecureRandom random = new SecureRandom();
        String ref;
        do {
            StringBuilder sb = new StringBuilder("TXN-");
            for (int i = 0; i < 10; i++) {
                sb.append(CHARS.charAt(random.nextInt(CHARS.length())));
            }
            ref = sb.toString();
        } while (paymentRepo.existsByTransactionReference(ref));

        return ref;
    }

    public Optional<Payment> findByOrder(Order order) {
        return paymentRepo.findByOrder(order);
    }

    public Optional<Payment> findByReference(String ref) {
        return paymentRepo.findByTransactionReference(ref);
    }

    public List<Payment> getByStatus(PaymentStatus status) {
        return paymentRepo.findByStatus(status);
    }

    public Payment updateStatus(Long id, PaymentStatus status) {
        Payment p = paymentRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Payment not found"));

        p.setStatus(status);
        return paymentRepo.save(p);
    }
}
