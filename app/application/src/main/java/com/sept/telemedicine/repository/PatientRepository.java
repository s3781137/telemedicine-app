package com.sept.telemedicine.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sept.telemedicine.model.Patient;

public interface PatientRepository extends JpaRepository<Patient, Integer> {

    @Query("SELECT id FROM Patient WHERE username = ?1")
    Integer findIdByUsername(@Param("username") String username);

    @Modifying
    @Query("UPDATE Patient SET gender = ?1, weight = ?2, height = ?3, contactNo = ?4, contactName = ?5 WHERE id = ?6")
    void updateDetails(String gender, double weight, double height, String contactNo, String contactName, int id);

    @Query("SELECT username FROM Patient Where id = ?1")
    Integer findUsername(String username);

}
