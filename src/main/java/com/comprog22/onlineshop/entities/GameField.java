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
@Table(name = "game_fields")
public class GameField {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "game_id", nullable = false)
    private Game game;

    @Column(name = "label", nullable = false)
    private String label; // e.g. UID, Username, Tagline, Region

    @Column(name = "field_type", nullable = false)
    private String fieldType; // TEXT, SELECT

    @Column(name = "required", nullable = false)
    private boolean required;

    @Column(name = "display_order", nullable = false)
    private int displayOrder;

    @Column(name = "options", columnDefinition = "TEXT")
    private String options;
    // used for SELECT fields (comma-separated or JSON string, ex "Region1, Region2, Region3")
}