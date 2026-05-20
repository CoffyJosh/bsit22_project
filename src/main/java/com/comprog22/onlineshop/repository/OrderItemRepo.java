package com.comprog22.onlineshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.OrderItem;

public interface OrderItemRepo extends JpaRepository<OrderItem, Long> {

    List<OrderItem> findByOrder(Order order);
}
