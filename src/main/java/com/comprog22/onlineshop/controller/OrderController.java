package com.comprog22.onlineshop.controller;

import java.util.List;

import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.annotation.AuthenticationPrincipal;

import com.comprog22.onlineshop.dto.CreateOrderRequest;
import com.comprog22.onlineshop.dto.OrderDetailsDTO;
import com.comprog22.onlineshop.dto.OrderListItemDTO;
import com.comprog22.onlineshop.dto.UserOrderStatsDTO;
import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.enums.OrderStatus;
import com.comprog22.onlineshop.services.OrderService;
import com.comprog22.onlineshop.services.UserService;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/orders")
public class OrderController {

    private final OrderService orderService;
    private final UserService userService;

    @PostMapping
    public ResponseEntity<Order> createOrder(@RequestBody CreateOrderRequest request) {
        Order order = orderService.createOrder(request);
        return ResponseEntity.ok(order);
    }

    @GetMapping
    public ResponseEntity<Page<OrderListItemDTO>> getOrders(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "50") int size,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) Long gameId) {
        Pageable pageable = PageRequest.of(
                page,
                size,
                Sort.by("createdAt").descending());

        Page<OrderListItemDTO> result;

        boolean hasStatus = status != null && !status.isBlank();
        boolean hasGame = gameId != null;

        if (hasStatus && hasGame) {

            result = orderService.getOrdersByStatusAndGameIdPaged(
                    OrderStatus.valueOf(status.toUpperCase()),
                    gameId,
                    pageable);

        } else if (hasStatus) {

            result = orderService.getOrdersByStatusPaged(
                    OrderStatus.valueOf(status.toUpperCase()),
                    pageable);

        } else if (hasGame) {

            result = orderService.getOrdersByGameIdPaged(
                    gameId,
                    pageable);

        } else {

            result = orderService.getAllOrders(pageable);
        }

        return ResponseEntity.ok(result);
    }

    // Getting User order list
    @GetMapping("/mine")
    public ResponseEntity<Page<OrderListItemDTO>> getMyOrders(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) Long gameId) {

        User user = userService.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));

        Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());

        Page<OrderListItemDTO> result = gameId != null
            ? orderService.getMyCompletedOrdersByGame(user.getId(), gameId, pageable)
            : orderService.getMyCompletedOrders(user.getId(), pageable);

        return ResponseEntity.ok(result);
    }

    @GetMapping("/mine/stats")
    public ResponseEntity<UserOrderStatsDTO> getMyOrderStats(@AuthenticationPrincipal UserDetails userDetails) {
        User user = userService.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));

        return ResponseEntity.ok(orderService.getUserOrderStats(user.getId()));
    }

    @GetMapping("/info")
    public ResponseEntity<OrderDetailsDTO> getOrderDetail(@RequestParam Long orderId){
        return ResponseEntity.ok(orderService.getOrderDetailsByOrderId(orderId).orElseThrow());
    }

}