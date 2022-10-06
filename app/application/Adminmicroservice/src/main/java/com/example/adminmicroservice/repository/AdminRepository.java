package com.example.adminmicroservice.repository;

import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.userdetails.UserDetails;

import com.example.adminmicroservice.model.Admin;

public interface AdminRepository extends JpaRepository<Admin, Integer> {

    @Query("SELECT id from Admin where username =?1")
    Integer findIdByUsername(@Param("username") String username);

    @Query("SELECT password FROM Admin WHERE username = ?1")
    String findPasswordByUsername(@Param("username") String password);

    Optional<Admin> findAdminByUsername(String admin);

    @Query("SELECT username FROM Admin Where id = ?1")
    String findUsername(@Param("username") String username);

    UserDetails findByUsername(String username);

    Admin getById(Long id);

    @Modifying
    @Transactional
    @Query("UPDATE Admin set token = ?1 where username = ?2")
    void setToken(@Param("token") String token, @Param("username") String username);
}
