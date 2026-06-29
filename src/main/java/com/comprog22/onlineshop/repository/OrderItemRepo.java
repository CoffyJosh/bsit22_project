package com.comprog22.onlineshop.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.OrderItem;

public interface OrderItemRepo extends JpaRepository<OrderItem, Long> {
    List<OrderItem> findByOrder(Order order);
    Optional<OrderItem> findByOrderId(Long orderId);
    
    @Query("SELECT COUNT(oi) FROM OrderItem oi WHERE oi.topupPackage.game.id = :gameId")
    Long countByGameId(@Param("gameId") Long gameId);
}
