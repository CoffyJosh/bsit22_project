package com.comprog22.onlineshop.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.Provider;
import com.comprog22.onlineshop.entities.ProviderProduct;
import com.comprog22.onlineshop.repository.ProviderProductRepo;
import com.comprog22.onlineshop.repository.ProviderRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProviderService {

    private final ProviderRepo providerRepo;
    private final ProviderProductRepo providerProductRepo;

    public List<Provider> getAllProviders() {
        return providerRepo.findAll();
    }

    public List<ProviderProduct> getProductsByProvider(Long providerId) {
        return providerProductRepo.findByProviderId(providerId);
    }
}