package com.comprog22.onlineshop.services;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.comprog22.onlineshop.entities.Voucher;
import com.comprog22.onlineshop.enums.Status;
import com.comprog22.onlineshop.repository.VoucherRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class VoucherService {

    private final VoucherRepo voucherRepo;

    public Voucher create(Voucher voucher) {
        return voucherRepo.save(voucher);
    }

    public Optional<Voucher> findById(Long id) {
        return voucherRepo.findById(id);
    }

    public Optional<Voucher> findByCode(String code) {
        return voucherRepo.findByCode(code);
    }

    public Voucher findVoucherByCode(String code) {
        return voucherRepo.findByCode(code).orElseThrow();
    }

    public List<Voucher> getAll() {
        return voucherRepo.findAll();
    }

    public boolean isValid(Voucher v) {
        if (v == null)
            return false;

        return v.getStatus() == Status.ACTIVE
                && v.getUsedCount() < v.getUsageLimit()
                && v.getExpirationDate().isAfter(LocalDateTime.now());
    }

    @Transactional
    public Voucher getValidVoucher(String code) {
        Voucher v = voucherRepo.findByCodeWithLock(code)
                .orElseThrow(() -> new RuntimeException("Voucher not found"));

        if (v.getStatus() != Status.ACTIVE) {
            throw new RuntimeException("Voucher inactive");
        }

        if (v.getUsedCount() >= v.getUsageLimit()) {
            throw new RuntimeException("Voucher fully used");
        }

        if (v.getExpirationDate().isBefore(LocalDateTime.now())) {
            throw new RuntimeException("Voucher expired");
        }
        return v;
    }

    @Transactional
    public Voucher incrementUsage(Voucher v) {
        System.out.println("\n\n\n FROM: " + (v.getUsedCount()));
        v.setUsedCount(v.getUsedCount() + 1);
        System.out.println("TO:  " + (v.getUsedCount()) +" \n\n\n");
        return voucherRepo.save(v);
    }

    @Transactional
    public Voucher decrementUsage(Voucher v) {
        v.setUsedCount(Math.max(0, v.getUsedCount() - 1));
        return voucherRepo.save(v);
    }

    public Voucher updateStatus(Long id, Status status) {
        Voucher v = voucherRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Voucher not found"));

        v.setStatus(status);
        return voucherRepo.save(v);
    }
}
