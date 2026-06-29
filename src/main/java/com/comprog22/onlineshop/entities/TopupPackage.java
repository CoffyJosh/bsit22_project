package com.comprog22.onlineshop.entities;

import java.time.LocalDateTime;
import java.math.BigDecimal;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.Formula;

import com.comprog22.onlineshop.enums.TopupPackageStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "topup_packages")
public class TopupPackage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "game_id", nullable = false)
    private Game game;

    @Column(name = "amount", nullable = false)
    private Integer amount;

    @Column(name = "price", nullable = false)
    private BigDecimal price;

    @Column(name = "region", nullable = true)
    private String region;

    @Enumerated(EnumType.STRING)
    private TopupPackageStatus status = TopupPackageStatus.AVAILABLE;

    @CreationTimestamp
    private LocalDateTime createdAt;

    @Formula("FLOOR(price / 100) * 10")
    private Integer bonus;

    // Amount + Bonus base on price
    @Formula("amount + FLOOR(price / 100) * 10")
    private BigDecimal totalAmount;
}