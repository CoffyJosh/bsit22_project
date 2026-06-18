package com.comprog22.onlineshop.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.OrderItem;
import com.comprog22.onlineshop.repository.OrderItemRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderItemService {

    private final OrderItemRepo orderItemRepo;

    public OrderItem create(OrderItem item) {
        return orderItemRepo.save(item);
    }

    public List<OrderItem> getByOrder(Order order) {
        return orderItemRepo.findByOrder(order);
    }
}
