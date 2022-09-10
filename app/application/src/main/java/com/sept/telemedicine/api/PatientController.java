package com.sept.telemedicine.api;

import com.sept.telemedicine.model.Patient;
import com.sept.telemedicine.service.PatientService;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/patient")
public class PatientController {

    @Autowired
    private PatientService service;

    @PostMapping
    public ResponseEntity<?> addPatient(@RequestBody Patient patient) {
        if (service.checkIfUsernameIsTaken(patient)) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", HttpStatus.NOT_ACCEPTABLE);
            response.put("errors", "Username is already taken");
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        } else {
            service.savePatient(patient);
            Patient currentPatient = service.findById(service.findIdByUsername(patient.getUsername()));
            Map<String, Object> response = new HashMap<>();
            response.put("id", currentPatient.getId());
            response.put("username", currentPatient.getUsername());
            return new ResponseEntity<>(response, HttpStatus.OK);
        }
    }

}
