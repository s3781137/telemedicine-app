package com.sept.healthinfo.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sept.healthinfo.model.HealthInformation;
import com.sept.healthinfo.repo.PatientHealthRepo;

@Service
public class HealthInfoService {

    @Autowired
    private PatientHealthRepo healthRepo;

    // updating the patient health information in the repo
    public void updateHealthInfo(HealthInformation healthInfo) {
        healthRepo.save(healthInfo);

    }

    // getting the patient healthinfo by id from the repo
    public Optional<HealthInformation> getHealthInfo(int id) {
        return healthRepo.findById(id);
    }

}
