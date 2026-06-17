package com.comprog22.onlineshop.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.comprog22.onlineshop.dto.CreatePaymentRequest;
import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.Payment;
import com.comprog22.onlineshop.services.OrderService;
import com.comprog22.onlineshop.services.PaymentService;

@RestController
@RequestMapping("/api/payments")
public class PaymentController {

    private final PaymentService paymentService;
    private final OrderService orderService;

    public PaymentController(PaymentService paymentService, OrderService orderService) {
        this.paymentService = paymentService;
        this.orderService = orderService;
    }

    @PostMapping
    public ResponseEntity<Payment> createPayment(@RequestBody CreatePaymentRequest request) {
        Order order = orderService.findById(request.getOrderId())
                .orElseThrow(() -> new RuntimeException("Order not found"));

        Payment payment = paymentService.createPayment(order, request.getPaymentMethod(), request.getAmount());

        return ResponseEntity.ok(payment);
    }
}