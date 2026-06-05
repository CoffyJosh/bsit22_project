package com.comprog22.onlineshop.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "game_images")
public class GameImage {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="id")
    private Long id;

    @Column(name = "url")
    private String url;

    @Column(name = "type")
    private String type;

    @Column(name = "sort_order")
    private int sortOrder;

    @ManyToOne
    @JoinColumn(name="game_id", nullable = false)
    private Game game;
}
