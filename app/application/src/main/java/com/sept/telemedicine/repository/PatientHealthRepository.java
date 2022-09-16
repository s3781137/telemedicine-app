package com.sept.telemedicine.repository;

import com.sept.telemedicine.model.PatientHealthInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository // jpa database
public interface PatientHealthRepository extends JpaRepository<PatientHealthInfo, Integer> {

}
