package com.sept.healthinfo.api;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sept.healthinfo.exceptions.PatientNotFound;
import com.sept.healthinfo.model.HealthInformation;
import com.sept.healthinfo.service.HealthInfoService;

@RestController
@RequestMapping("/healthinfo")
public class HealthInfoController {

    // This method is used to update a patient's health information
    // the patient can go to http://localhost:8080/patient/updateHealthInfo and
    // specify their id to update their diseases.

    @Autowired
    private HealthInfoService service;

    @GetMapping("/getHealthInfo/{id}")
    public ResponseEntity<?> getHealthInfo(@PathVariable(name = "id") int id) {
        try {
            HealthInformation healthInformation = service.getHealthInfo(id).get();
            return new ResponseEntity<>(healthInformation, HttpStatus.OK);
        } catch (Exception e) {
            throw new PatientNotFound("Patient with that username not found");
        }
    }

    @PutMapping("/updateHealthInfo")
    public ResponseEntity<?> updateHealthInfo(@RequestBody HealthInformation healthInfo) {
        try {
            service.updateHealthInfo(healthInfo);
            Map<String, Object> response = new HashMap<>();
            response.put("id", healthInfo.getId());
            response.put("message", "health information registered");
            return new ResponseEntity<>(response, HttpStatus.OK);

        } catch (Exception e) {
            throw new PatientNotFound("Patient database error");
        }
    }

}
