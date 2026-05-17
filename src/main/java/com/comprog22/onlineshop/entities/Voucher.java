package com.comprog22.onlineshop.entities;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import com.comprog22.onlineshop.enums.DiscountType;
import com.comprog22.onlineshop.enums.Status;
import com.comprog22.onlineshop.enums.VoucherStatus;
import com.comprog22.onlineshop.enums.VoucherType;

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
import tools.jackson.databind.cfg.EnumFeature;

@Entity
@Data
@Table(name = "vouchers")
public class Voucher {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "product_id", nullable = true)
    private Product product;

    @Column(name = "code", nullable = false)
    private String code;

    @Column(name = "value", nullable = false)
    private Double discountValue; // ₱20 OR 20%

    @Column(name = "usage_limit", nullable = false)
    private int usageLimit = 1;

    @Column(name = "used_count", nullable = false)
    private int usedCount = 0;

    @Enumerated(EnumType.STRING)
    @Column(name = "type", nullable = false)
    private DiscountType type;

    @Column(name = "expiration_date", nullable = false)
    private LocalDateTime expirationDate;

    @CreationTimestamp
    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private Status status;
}