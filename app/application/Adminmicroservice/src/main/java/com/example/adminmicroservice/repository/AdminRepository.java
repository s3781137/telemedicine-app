package com.example.adminmicroservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.adminmicroservice.model.Admin;

public interface AdminRepository extends JpaRepository<Admin, Integer> {

}
