package com.sept.telemedicine.api;

import com.sept.telemedicine.dto.PatientDto;
import com.sept.telemedicine.exceptions.PatientNotFound;
import com.sept.telemedicine.model.Patient;
import com.sept.telemedicine.model.PatientHealthInfo;
import com.sept.telemedicine.service.PatientHealthService;
import com.sept.telemedicine.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/patient")
public class PatientController { // api/controller methods for patient, CRUD methods between http/client and
                                 // service layer

    @Autowired
    private PatientService service;

    @Autowired
    private PatientHealthService healthService;

    // Retrieves all patient accounts
    @GetMapping("/list")
    public List<Patient> getPatients() {
        return service.findAll();
    }

    // Retrieves patient account information (patient personal information and
    // account information, not medical information)
    @GetMapping("/getBy/{username}")
    public ResponseEntity<?> getPatientByUsername(@PathVariable(name = "username") String username) {
        try {
            Patient patient = service.getPatientByUsername(username);
            return new ResponseEntity<>(patient, HttpStatus.OK);
        } catch (Exception e) {
            throw new PatientNotFound("Patient with that username not found");
        }
    }

    // Saves new patient information and stores it in the database [patient]. Also
    // creates a default medical information with their id in [patient_health] table
    @PostMapping("/registerPatient")
    public ResponseEntity<?> addPatient(@RequestBody Patient patient) {
        if (service.checkIfUsernameIsFree(patient)) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", HttpStatus.NOT_ACCEPTABLE);
            response.put("errors", "Username is already taken");
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        } else if (!patient.getPassword().equals(patient.getConfirmPassword())) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", HttpStatus.NOT_ACCEPTABLE);
            response.put("errors", "Your both passwords should be same.");
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        } else {
            Patient currentPatient = service.savePatient(patient);
            healthService.createPatientHealthInfo(currentPatient.getId());
            Map<String, Object> response = new HashMap<>();
            response.put("id", currentPatient.getId());
            response.put("username", currentPatient.getUsername());
            return new ResponseEntity<>(response, HttpStatus.OK);
        }
    }

    // updates patient personal information (modify patient information)
    @PutMapping("/update")
    public ResponseEntity<?> updatePatient(@RequestBody PatientDto patient) {
        try {
            return service.updatePatient(patient.getStatus(), patient.getGender(), patient.getWeight(),
                    patient.getHeight(),
                    patient.getContactNo(), patient.getContactName(), patient.getId());
        } catch (Exception e) {
            throw new PatientNotFound("Patient database error");
        }
    }

    // delete patient (admin)
    @DeleteMapping("/delete/{username}")
    public ResponseEntity<?> deletePatient(@PathVariable String username) {
        try {
            service.deletePatient(username);
            return new ResponseEntity<>("Patient deleted", HttpStatus.OK);
        } catch (Exception e) {
            throw new PatientNotFound("Patient database error");
        }
    }

    // login by getting entered username and password and checking with database
    @GetMapping("/login")
    public ResponseEntity<?> login(@RequestParam String username, @RequestParam String password) {
        try {
            boolean patientfound = service.checkLoginCredentials(username, password);
            return new ResponseEntity<>(patientfound, HttpStatus.OK);
        } catch (Exception e) {
            throw new PatientNotFound("Patient with that username not found");
        }
        // to login go to:
        // http://localhost:8080/patient/login?username=aishwarya&password=BTS
    }

    // update medical health information
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
