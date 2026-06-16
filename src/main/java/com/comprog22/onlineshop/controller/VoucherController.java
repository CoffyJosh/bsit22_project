package com.comprog22.onlineshop.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.comprog22.onlineshop.entities.Voucher;
import com.comprog22.onlineshop.services.VoucherService;

@RestController
@RequestMapping("/api/voucher")
public class VoucherController {
    private final VoucherService voucherService;

    public VoucherController(VoucherService voucherService) {
        this.voucherService = voucherService;
    }

    @GetMapping()
    public ResponseEntity<Voucher> getVoucher(@RequestParam("code") String code) {
        return ResponseEntity.ok(voucherService.findVoucherByCode(code));
    }
}