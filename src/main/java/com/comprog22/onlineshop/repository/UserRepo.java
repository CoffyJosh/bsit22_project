package com.comprog22.onlineshop.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.enums.UserStatus;


public interface UserRepo extends JpaRepository<User, Long>{
    Optional<User> findByEmail(String email);

    Optional<User> findByEmailAndPassword(String email, String password);
    boolean existsByEmail(String email);

    long countByStatus(UserStatus status);

    boolean existsByEmailAndPasswordIsNull(String email);
}
