package com.comprog22.onlineshop.utils;

import at.favre.lib.crypto.bcrypt.BCrypt;

public class PasswordUtil {

    private static final int COST = 12;

    public static String hash(String rawPassword) {
        return BCrypt.withDefaults()
                .hashToString(COST, rawPassword.toCharArray());
    }

    public static boolean matches(String rawPassword, String hashedPassword) {
        return BCrypt.verifyer()
                .verify(rawPassword.toCharArray(), hashedPassword).verified;
    }
}