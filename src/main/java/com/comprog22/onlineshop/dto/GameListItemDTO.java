package com.comprog22.onlineshop.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GameListItemDTO {

    private Long id;
    private String name;
    private String imageUrl;
    private String packageName;
    private String status;
    private LocalDateTime createdAt;
}