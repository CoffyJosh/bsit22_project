package com.comprog22.onlineshop.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comprog22.onlineshop.entities.ApiLog;
import com.comprog22.onlineshop.entities.Order;
import com.comprog22.onlineshop.repository.ApiLogRepo;

@Service
public class ApiLogService {

    @Autowired
    private ApiLogRepo apiLogRepo;

    public ApiLog save(ApiLog log) {
        return apiLogRepo.save(log);
    }

    public List<ApiLog> getByOrder(Order order) {
        return apiLogRepo.findByOrder(order);
    }
}