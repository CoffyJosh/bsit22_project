package com.comprog22.onlineshop.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.enums.OrderStatus;

public interface OrderRepo extends JpaRepository<Order, Long> {
    Optional<Order> findByTrackingCode(String trackingCode);    
    Optional<Order> findById(Long id);
    List<Order> findByUser(User user);
    List<Order> findByStatus(OrderStatus status);
    boolean existsByTrackingCode(String code);
    List<Order> findByCreatedAtBetweenAndStatus(LocalDateTime start, LocalDateTime end, OrderStatus status);
    
}