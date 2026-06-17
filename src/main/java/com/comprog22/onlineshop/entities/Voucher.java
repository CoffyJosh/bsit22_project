package com.comprog22.onlineshop.entities;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import com.comprog22.onlineshop.enums.DiscountType;
import com.comprog22.onlineshop.enums.Status;

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
import jakarta.persistence.Version;
import lombok.Data;

@Entity
@Data
@Table(name = "vouchers")
public class Voucher {

    @Version
    private Integer version;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "topup_package_id", nullable = true)
    private TopupPackage topupPackage;

    @Column(name = "code", nullable = false, unique = true)
    private String code;

    // Single source of truth for discount
    @Column(name = "discount_value", nullable = false)
    private BigDecimal discountValue;

    @Enumerated(EnumType.STRING)
    @Column(name = "type", nullable = false)
    private DiscountType type;

    @Column(name = "usage_limit", nullable = false)
    private int usageLimit = 1;

    @Column(name = "used_count", nullable = false)
    private int usedCount = 0;

    @Column(name = "expiration_date", nullable = false)
    private LocalDateTime expirationDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private Status status;

    @CreationTimestamp
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
}