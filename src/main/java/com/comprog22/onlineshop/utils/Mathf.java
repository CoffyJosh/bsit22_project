package com.comprog22.onlineshop.utils;

import java.math.BigDecimal;

public final class Mathf {

    private Mathf() {
        // prevent instantiation
    }

    // -------------------------
    // Clamp (int)
    // -------------------------
    public static int clamp(int value, int min, int max) {
        return Math.max(min, Math.min(max, value));
    }

    // -------------------------
    // Clamp (float)
    // -------------------------
    public static float clamp(float value, float min, float max) {
        return Math.max(min, Math.min(max, value));
    }

    // -------------------------
    // Clamp (double)
    // -------------------------
    public static double clamp(double value, double min, double max) {
        return Math.max(min, Math.max(value, min));
    }

    // -------------------------
    // Clamp (BigDecimal) - useful for your system
    // -------------------------
    public static BigDecimal clamp(BigDecimal value, BigDecimal min, BigDecimal max) {
        if (value.compareTo(min) < 0)
            return min;
        if (value.compareTo(max) > 0)
            return max;
        return value;
    }

    // -------------------------
    // Lerp (float)
    // -------------------------
    public static float lerp(float a, float b, float t) {
        t = clamp(t, 0f, 1f);
        return a + (b - a) * t;
    }

    // -------------------------
    // Lerp (double)
    // -------------------------
    public static double lerp(double a, double b, double t) {
        t = clamp(t, 0.0, 1.0);
        return a + (b - a) * t;
    }

    // -------------------------
    // Abs
    // -------------------------
    public static int abs(int value) {
        return Math.abs(value);
    }

    public static float abs(float value) {
        return Math.abs(value);
    }

    public static double abs(double value) {
        return Math.abs(value);
    }

    // -------------------------
    // Min / Max (optional convenience)
    // -------------------------
    public static int min(int a, int b) {
        return Math.min(a, b);
    }

    public static int max(int a, int b) {
        return Math.max(a, b);
    }
}