package com.comprog22.onlineshop.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.Game;
import com.comprog22.onlineshop.entities.TopupPackage;
import com.comprog22.onlineshop.enums.TopupPackageStatus;

import com.comprog22.onlineshop.repository.TopupPackageRepo;

@Service
public class TopupPackageService {
 @Autowired
    private TopupPackageRepo topupPackageRepo;

    public TopupPackage create(TopupPackage product) {
        return topupPackageRepo.save(product);
    }

    public Optional<TopupPackage> findById(Long id) {
        return topupPackageRepo.findById(id);
    }

    public List<TopupPackage> getAll() {
        return topupPackageRepo.findAll();
    }

    public List<TopupPackage> getByGame(Game game) {
        return topupPackageRepo.findByGame(game);
    }

    public List<TopupPackage> getByStatus(TopupPackageStatus status) {
        return topupPackageRepo.findByStatus(status);
    }

    public TopupPackage updateStatus(Long id, TopupPackageStatus status) {
        TopupPackage topupPackage = topupPackageRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Package not found"));

        topupPackage.setStatus(status);
        return topupPackageRepo.save(topupPackage);
    }

    public TopupPackage archive(Long id) {
        return updateStatus(id, TopupPackageStatus.ARCHIVED);
    }
}
