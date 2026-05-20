package com.comprog22.onlineshop.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.enums.OrderStatus;
import com.comprog22.onlineshop.repository.OrderRepo;

@Service
public class OrderService {

    @Autowired
    private OrderRepo orderRepo;

    public Order create(Order order) {
        return orderRepo.save(order);
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
}
