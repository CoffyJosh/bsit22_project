package com.comprog22.onlineshop.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.OrderItem;

public interface OrderItemRepo extends JpaRepository<OrderItem, Long> {
    List<OrderItem> findByOrder(Order order);
    Optional<OrderItem> findByOrderId(Long orderId);
    
    @Query("SELECT COUNT(oi) FROM OrderItem oi WHERE oi.topupPackage.game.id = :gameId")
    Long countByGameId(@Param("gameId") Long gameId);

    @Query(value = """
            SELECT g.*
            FROM games g
            JOIN topup_packages tp ON tp.game_id = g.id
            JOIN order_items oi ON oi.topup_package_id = tp.id
            GROUP BY g.id
            ORDER BY COUNT(oi.id) DESC
            LIMIT 5
            """, nativeQuery = true)
    List<Game> findTop5GamesByOrderCount();
}
