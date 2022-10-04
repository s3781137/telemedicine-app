package com.sept.doctor.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.cdi.JpaRepositoryExtension;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Repository;

import com.sept.doctor.model.Doctor;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transaction;
import javax.transaction.Transactional;

@Repository
public interface DoctorRepository extends JpaRepository<Doctor, Integer> {

    @Query("SELECT id from Doctor where username =?1")
    Integer findIdByUsername(@Param("username") String username);

    @Query("SELECT password FROM Doctor WHERE username = ?1")
    String findPasswordByUsername(@Param("username") String password);

    Optional<Doctor> findDoctorByUsername(String doctor);

    @Query("SELECT username FROM Doctor Where id = ?1")
    String findUsername(@Param("username") String username);

    UserDetails findByUsername(String username);

    Doctor getById(Long id);

    @Modifying
    @Transactional
    @Query("UPDATE Doctor set token = ?1 where username = ?2")
    void setToken(@Param("token") String token, @Param("username") String username);

}
