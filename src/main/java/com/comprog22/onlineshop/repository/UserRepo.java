package com.comprog22.onlineshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.comprog22.onlineshop.entities.User;


public interface UserRepo extends JpaRepository<User, Long>{

}
