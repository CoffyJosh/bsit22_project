package com.comprog22.onlineshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import com.comprog22.onlineshop.entities.ProviderProduct;

public interface ProviderProductRepo extends JpaRepository<ProviderProduct, Long> {
    List<ProviderProduct> findByProviderId(Long providerId);
    Optional<ProviderProduct> findById(Long id);
}