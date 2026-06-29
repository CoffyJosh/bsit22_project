package com.comprog22.onlineshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.comprog22.onlineshop.entities.ProviderProduct;

public interface ProviderProductRepository extends JpaRepository<ProviderProduct, Long> {
    List<ProviderProduct> findByProductCodeIgnoreCase(String productCode);
}