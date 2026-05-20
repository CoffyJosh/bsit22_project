package com.comprog22.onlineshop.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.entities.Product;
import com.comprog22.onlineshop.enums.ProductStatus;

import com.comprog22.onlineshop.repository.ProductRepo;

@Service
public class ProductService {
 @Autowired
    private ProductRepo productRepo;

    public Product create(Product product) {
        return productRepo.save(product);
    }

    public Optional<Product> findById(Long id) {
        return productRepo.findById(id);
    }

    public List<Product> getAll() {
        return productRepo.findAll();
    }

    public List<Product> getByGame(Game game) {
        return productRepo.findByGame(game);
    }

    public List<Product> getByStatus(ProductStatus status) {
        return productRepo.findByStatus(status);
    }

    public Product updateStatus(Long id, ProductStatus status) {
        Product product = productRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        product.setStatus(status);
        return productRepo.save(product);
    }

    public Product archive(Long id) {
        return updateStatus(id, ProductStatus.ARCHIVED);
    }
}
