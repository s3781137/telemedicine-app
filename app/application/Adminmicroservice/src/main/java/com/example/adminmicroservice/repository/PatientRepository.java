package com.example.adminmicroservice.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.adminmicroservice.dto.Patient;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Integer> {

    // finding a patient by username in the database
    @Query("SELECT id FROM Patient WHERE username = ?1")
    Integer findIdByUsername(@Param("username") String username);

    // finding the passwrod by username in the database
    @Query("SELECT password FROM Patient WHERE username = ?1")
    String findPasswordByUsername(@Param("username") String password);

    Optional<Patient> findPatientByUsername(String username);

    // modifying a patient's details in in the database.
    @Modifying
    @Query("UPDATE Patient SET gender = ?1, weight = ?2, height = ?3, contactNo = ?4, contactName = ?5 WHERE id = ?6")
    void updateDetails(
            @Param("gender") String gender,
            @Param("weight") double weight,
            @Param("height") double height, @Param("contactNo") String contactNo,
            @Param("contactName") String contactName,
            @Param("id") int id);

    // finding a username thorugh patient id from the database
    @Query("SELECT username FROM Patient Where id = ?1")
    String findUsername(@Param("username") String username);

}
