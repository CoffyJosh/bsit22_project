package com.comprog22.onlineshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.comprog22.onlineshop.entities.Product;

public interface ProductRepo extends JpaRepository<Product, Long> {

}
