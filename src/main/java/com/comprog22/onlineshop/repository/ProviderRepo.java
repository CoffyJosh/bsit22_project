package com.comprog22.onlineshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.comprog22.onlineshop.entities.Provider;

public interface ProviderRepo extends JpaRepository<Provider, Long> {
}