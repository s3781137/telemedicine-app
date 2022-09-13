package com.sept.telemedicine.repository;

import com.sept.telemedicine.model.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Integer> {

    @Query("SELECT id FROM Patient WHERE username = ?1")
    Integer findIdByUsername(@Param("username") String username);

    Optional<Patient> findPatientByUsername(String username);

    @Modifying
    @Query("UPDATE Patient SET gender = ?1, weight = ?2, height = ?3, contactNo = ?4, contactName = ?5, status = ?6 WHERE id = ?7")
    void updateDetails(
            @Param("gender") String gender,
            @Param("weight") double weight,
            @Param("height") double height, @Param("contactNo") String contactNo,
            @Param("contactName") String contactName,
            @Param("status") String status,
            @Param("id") int id);

    @Query("SELECT username FROM Patient Where id = ?1")
    String findUsername(@Param("username") String username);

}
