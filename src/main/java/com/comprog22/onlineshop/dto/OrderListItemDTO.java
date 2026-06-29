package com.comprog22.onlineshop.dto;

import com.comprog22.onlineshop.entities.OrderItem;
import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.entities.TopupPackage;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class OrderListItemDTO {
    private Long orderId;
    private String trackingCode;
    private Long gameId;
    private String gameName;
    private String gameImageUrl;
    private String packageName;
    private BigDecimal finalAmount;
    private String status;
    private LocalDateTime createdAt;

    // Mapping Constructor utilizing the OrderItem model context
    public OrderListItemDTO(OrderItem item) {
        Order parentOrder = item.getOrder();
        TopupPackage pkg = item.getTopupPackage();

        if (parentOrder != null) {
            this.orderId = parentOrder.getId();
            this.trackingCode = parentOrder.getTrackingCode();
            this.finalAmount = parentOrder.getFinalAmount();
            // Convert Enum status string safely to match your validation requirements
            this.status = parentOrder.getStatus() != null ? parentOrder.getStatus().name() : "UNKNOWN";
            this.createdAt = parentOrder.getCreatedAt();
        }

        if (pkg != null) {
            this.packageName = pkg.getGame().getPackageName();
            // Assuming your TopupPackage model maps to a Game entity via getGame()
            if (pkg.getGame() != null) {
                this.gameId = pkg.getGame().getId();
                this.gameName = pkg.getGame().getName();
            }
        }
    }
}