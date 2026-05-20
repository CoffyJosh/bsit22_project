package com.comprog22.onlineshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.comprog22.onlineshop.entities.ApiLog;
import com.comprog22.onlineshop.entities.Order;

public interface ApiLogRepo extends JpaRepository<ApiLog, Long> {

    List<ApiLog> findByOrder(Order order);
}
