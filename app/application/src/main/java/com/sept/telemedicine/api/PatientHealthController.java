package com.sept.telemedicine.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.deser.impl.CreatorCandidate.Param;
import com.sept.telemedicine.exceptions.PatientNotFound;
import com.sept.telemedicine.model.PatientHealthInfo;
import com.sept.telemedicine.service.PatientHealthService;

@RestController
@RequestMapping("patient_health")
public class PatientHealthController {

    @Autowired
    private PatientHealthService healthService;

    @PostMapping("/addHealthInfo")
    public ResponseEntity<?> addHealthInfo(@RequestBody PatientHealthInfo info) {
        if (healthService.findById(info.getId()) == null) {
            healthService.createPatientHealthInfo(info);
            return new ResponseEntity<>("Patient health info added", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("Patient already exists", HttpStatus.OK);
        }
    }

    @PutMapping("/updateHealthInfo")
    public ResponseEntity<?> updateHealthInfo(@RequestBody PatientHealthInfo healthInfo) {
        try {
            return healthService.updatePatientHealth(healthInfo.getId(), healthInfo.getCancer(),
                    healthInfo.getDiabetes(),
                    healthInfo.getHeartDisease(), healthInfo.getKidneyDisease(), healthInfo.getLiverDisease(),
                    healthInfo.getMedicalProblems(),
                    healthInfo.getMedication(), healthInfo.getMedicationDescription(), healthInfo.getPastSurgeries());

        } catch (Exception e) {
            throw new PatientNotFound("PatientHealth database error");
        }
    }
}
