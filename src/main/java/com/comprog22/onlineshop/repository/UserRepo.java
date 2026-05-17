package com.comprog22.onlineshop.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.comprog22.onlineshop.entities.User;


public interface UserRepo extends JpaRepository<User, Long>{
    Optional<User> findByEmail(String email);
}
