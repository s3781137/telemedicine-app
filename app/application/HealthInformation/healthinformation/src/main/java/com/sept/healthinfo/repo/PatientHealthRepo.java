package com.sept.healthinfo.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.sept.healthinfo.model.HealthInformation;

import java.util.Optional;

//this class stores the patient health informaitno into the repo

@Repository
public interface PatientHealthRepo extends JpaRepository<HealthInformation, Integer> {

}