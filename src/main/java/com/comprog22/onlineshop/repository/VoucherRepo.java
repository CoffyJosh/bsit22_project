package com.comprog22.onlineshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.comprog22.onlineshop.entities.Voucher;
import com.comprog22.onlineshop.enums.Status;

import jakarta.persistence.LockModeType;

public interface VoucherRepo extends JpaRepository<Voucher, Long> {

    Optional<Voucher> findByCode(String code);

    List<Voucher> findByStatus(Status status);

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT v FROM Voucher v WHERE v.code = :code")
    Optional<Voucher> findByCodeWithLock(@Param("code") String code);
}
