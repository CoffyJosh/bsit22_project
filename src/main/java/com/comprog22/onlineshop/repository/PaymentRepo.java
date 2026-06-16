package com.comprog22.onlineshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.Payment;
import com.comprog22.onlineshop.enums.PaymentStatus;

public interface PaymentRepo extends JpaRepository<Payment, Long> {
    Optional<Payment> findByOrder(Order order);
    Optional<Payment> findByTransactionReference(String transactionReference);
    boolean existsByTransactionReference(String transactionReference);
    List<Payment> findByStatus(PaymentStatus status);
    
}