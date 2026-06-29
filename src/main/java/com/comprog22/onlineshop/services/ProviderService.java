package com.comprog22.onlineshop.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.Provider;
import com.comprog22.onlineshop.entities.ProviderProduct;
import com.comprog22.onlineshop.repository.ProviderProductRepo;
import com.comprog22.onlineshop.repository.ProviderRepo;

import com.comprog22.onlineshop.dto.ProviderOptionDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProviderService {

    private final ProviderRepo providerRepo;
    private final ProviderProductRepo providerProductRepo;

    public List<ProviderOptionDTO> getAllProviders() {
        List<Provider> all = providerRepo.findAll();
        return all.stream()
                .map(pp -> new ProviderOptionDTO(pp.getId(), pp.getName()))
                .distinct()
                .toList();
    }

    public List<ProviderOptionDTO> lookupProvidersByProductCode(String productCode) {
        List<ProviderProduct> matches = providerProductRepo.findByProductCodeIgnoreCase(productCode);

        return matches.stream()
                .map(pp -> new ProviderOptionDTO(pp.getProvider().getId(), pp.getProvider().getName()))
                .distinct()
                .toList();
    }
}