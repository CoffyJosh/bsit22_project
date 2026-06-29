package com.comprog22.onlineshop.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.comprog22.onlineshop.dto.ProviderOptionDTO;
import com.comprog22.onlineshop.entities.Provider;
import com.comprog22.onlineshop.services.ProviderService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/provider")
@RequiredArgsConstructor
public class ProviderProductController {

    private final ProviderService providerService;

    @GetMapping("/lookup")
    public ResponseEntity<List<ProviderOptionDTO>> lookupByProductCode(@RequestParam String code) {
        return ResponseEntity.ok(providerService.lookupProvidersByProductCode(code));
    }

    @GetMapping("/get-all")
    public ResponseEntity<List<ProviderOptionDTO>> getALlProvider() {
        return ResponseEntity.ok(providerService.getAllProviders());
    }
}