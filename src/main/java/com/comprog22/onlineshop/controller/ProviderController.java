package com.comprog22.onlineshop.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.comprog22.onlineshop.entities.Provider;
import com.comprog22.onlineshop.entities.ProviderProduct;
import com.comprog22.onlineshop.services.ProviderService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/providers")
@RequiredArgsConstructor
public class ProviderController {

    private final ProviderService providerService;

    @GetMapping
    public ResponseEntity<List<Provider>> getAllProviders() {
        return ResponseEntity.ok(providerService.getAllProviders());
    }

    @GetMapping("/{providerId}/products")
    public ResponseEntity<List<ProviderProduct>> getProviderProducts(@PathVariable Long providerId) {
        return ResponseEntity.ok(providerService.getProductsByProvider(providerId));
    }
}