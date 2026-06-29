package com.comprog22.onlineshop.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "providers")
public class Provider {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(name = "merchant_id", nullable = false)
    private String merchantId;

    @Column(name = "api_key", nullable = false)
    private String apiKey;

    @Column(name = "secret_key", nullable = false)
    private String secretKey;
}