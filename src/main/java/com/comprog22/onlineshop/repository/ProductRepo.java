package com.comprog22.onlineshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.entities.Product;
import com.comprog22.onlineshop.enums.ProductStatus;

import java.util.List;

public interface ProductRepo extends JpaRepository<Product, Long> {

    List<Product> findByGame(Game game);

    List<Product> findByStatus(ProductStatus status);

    List<Product> findByGameAndStatus(Game game, ProductStatus status);
}