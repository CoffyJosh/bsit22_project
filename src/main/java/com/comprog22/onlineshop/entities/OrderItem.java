package com.comprog22.onlineshop.entities;

import java.math.BigDecimal;

import org.hibernate.annotations.Formula;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "order_items")
public class OrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;

    @ManyToOne
    @JoinColumn(name = "topup_package_id", nullable = false)
    private TopupPackage topupPackage;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    @Column(name = "price", nullable = false)
    private BigDecimal price;

    @Formula("price * quantity")
    private BigDecimal subtotal;

    @Column(name = "account_id", nullable = false) // Account ID user have entered
    private String accountId;

    @Column(name = "server", nullable = true) // Server user have entered
    private String server;
}

