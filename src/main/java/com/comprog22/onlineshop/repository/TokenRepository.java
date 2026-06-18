package com.comprog22.onlineshop.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.comprog22.onlineshop.entities.Token;

public interface TokenRepository extends JpaRepository<Token, Long> {
    Optional<Token> findByEmailAndPurpose(String email, String purpose);

    Optional<Token> findByToken(String token);

    void deleteByEmailAndPurpose(String email, String purpose);
}
