package com.comprog22.onlineshop.repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.entities.Payment;
import com.comprog22.onlineshop.enums.OrderStatus;

public interface OrderRepo extends JpaRepository<Order, Long> {

    Optional<Order> findByTrackingCode(String trackingCode);

    List<Order> findByUser(User user);

    List<Order> findByStatus(OrderStatus status);

    boolean existsByTrackingCode(String code);

    List<Order> findByCreatedAtBetweenAndStatus(LocalDateTime start, LocalDateTime end, OrderStatus status);

    Page<Order> findAll(Pageable pageable);

    Page<Order> findByStatus(OrderStatus status, Pageable pageable);

    Page<Order> findByCreatedAtBetween(LocalDateTime startDate, LocalDateTime endDate, Pageable pageable);

    Page<Order> findByStatusAndCreatedAtBetween(OrderStatus status, LocalDateTime startDate, LocalDateTime endDate, Pageable pageable);

    @Query("""
            SELECT o
            FROM Order o
            JOIN OrderItem oi ON oi.order = o
            JOIN TopupPackage tp ON oi.topupPackage = tp
            JOIN Game g ON tp.game = g
            WHERE LOWER(g.name) LIKE LOWER(CONCAT('%', :gameName, '%'))
            """)
    Page<Order> findByGameName(@Param("gameName") String gameName, Pageable pageable);

    @Query("""
            SELECT o
            FROM Order o
            JOIN OrderItem oi ON oi.order = o
            JOIN TopupPackage tp ON oi.topupPackage = tp
            JOIN Game g ON tp.game = g
            WHERE o.status = :status
            AND LOWER(g.name) LIKE LOWER(CONCAT('%', :gameName, '%'))
            """)
    Page<Order> findByStatusAndGameName(@Param("status") OrderStatus status, @Param("gameName") String gameName, Pageable pageable);

    @Query("""
                SELECT o
                FROM Order o
                JOIN OrderItem oi ON oi.order = o
                JOIN TopupPackage tp ON oi.topupPackage = tp
                JOIN Game g ON tp.game = g
                WHERE g.id = :gameId
            """)
    Page<Order> findByGameId(@Param("gameId") Long gameId, Pageable pageable);

    @Query("""
                SELECT o
                FROM Order o
                JOIN OrderItem oi ON oi.order = o
                JOIN TopupPackage tp ON oi.topupPackage = tp
                JOIN Game g ON tp.game = g
                WHERE o.status = :status
                  AND g.id = :gameId
            """)
    Page<Order> findByStatusAndGameId(@Param("status") OrderStatus status, @Param("gameId") Long gameId, Pageable pageable);

    @Query("""
            SELECT o FROM Order o
            WHERE o.user.id = :userId
            AND o.status = 'COMPLETED'
            """)
    Page<Order> findCompletedByUserId(@Param("userId") Long userId, Pageable pageable);

    @Query("""
            SELECT o FROM Order o
            WHERE o.user.id = :userId
            AND o.status = 'COMPLETED'
            AND EXISTS (
                SELECT 1 FROM OrderItem oi
                WHERE oi.order = o
                AND oi.topupPackage.game.id = :gameId
            )
            """)
    Page<Order> findCompletedByUserIdAndGameId(@Param("userId") Long userId, @Param("gameId") Long gameId, Pageable pageable);

    
    @Query("""
            SELECT
                COUNT(o),
                COALESCE(SUM(o.finalAmount), 0),
                SUM(CASE WHEN o.voucher IS NOT NULL THEN 1 ELSE 0 END)
            FROM Order o
            WHERE o.user.id = :userId
            AND o.status = 'COMPLETED'
            """)
    List<Object[]> getUserOrderStats(@Param("userId") Long userId);

    @Query("""
            SELECT o FROM Order o
            LEFT JOIN Payment p ON p.order = o
            WHERE o.user.id = :userId
            AND o.status = 'COMPLETED'
            AND (
                LOWER(o.trackingCode) LIKE LOWER(CONCAT('%', :search, '%'))
                OR LOWER(p.transactionReference) LIKE LOWER(CONCAT('%', :search, '%'))
            )
            """)
    Page<Order> findCompletedByUserIdAndSearch(@Param("userId") Long userId, @Param("search") String search, Pageable pageable);

    @Query("""
            SELECT o FROM Order o
            LEFT JOIN Payment p ON p.order = o
            WHERE o.user.id = :userId
            AND o.status = 'COMPLETED'
            AND EXISTS (
                SELECT 1 FROM OrderItem oi
                WHERE oi.order = o
                AND oi.topupPackage.game.id = :gameId
            )
            AND (
                LOWER(o.trackingCode) LIKE LOWER(CONCAT('%', :search, '%'))
                OR LOWER(p.transactionReference) LIKE LOWER(CONCAT('%', :search, '%'))
            )
            """)
    Page<Order> findCompletedByUserIdAndGameIdAndSearch(@Param("userId") Long userId, @Param("gameId") Long gameId, @Param("search") String search, Pageable pageable);

    @Query("""
            SELECT o
            FROM Order o
            JOIN OrderItem oi ON oi.order = o
            JOIN TopupPackage tp ON oi.topupPackage = tp
            JOIN Game g ON tp.game = g
            LEFT JOIN Payment p ON p.order = o
            WHERE (:status IS NULL OR o.status = :status)
            AND (:gameId IS NULL OR g.id = :gameId)
            AND (
                :search IS NULL OR :search = ''
                OR LOWER(o.trackingCode) LIKE LOWER(CONCAT('%', :search, '%'))
                OR LOWER(p.transactionReference) LIKE LOWER(CONCAT('%', :search, '%'))
            )
            """)
    Page<Order> searchOrders(@Param("status") OrderStatus status, @Param("gameId") Long gameId, @Param("search") String search, Pageable pageable);

    @Query("SELECT COALESCE(SUM(o.finalAmount), 0) FROM Order o WHERE o.id IN (SELECT DISTINCT oi.order.id FROM OrderItem oi WHERE oi.topupPackage.game.id = :gameId)")
    BigDecimal sumRevenueByGameId(@Param("gameId") Long gameId);
}