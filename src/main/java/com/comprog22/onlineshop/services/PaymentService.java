package com.comprog22.onlineshop.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.Payment;
import com.comprog22.onlineshop.enums.PaymentStatus;
import com.comprog22.onlineshop.repository.PaymentRepo;

@Service
public class PaymentService {

    @Autowired
    private PaymentRepo paymentRepo;

    public Payment create(Payment payment) {
        return paymentRepo.save(payment);
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
