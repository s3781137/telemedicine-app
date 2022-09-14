package com.sept.telemedicine.api;

import com.mysql.cj.protocol.x.Ok;
import com.sept.telemedicine.dto.PatientDto;
import com.sept.telemedicine.exceptions.PatientNotFound;
import com.sept.telemedicine.model.Patient;
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
public class PatientController {

    @Autowired
    private PatientService service;

    @GetMapping("/list")
    public List<Patient> getPatients() {
        return service.findAll();
    }

    @GetMapping("/getBy/{username}")
    public ResponseEntity<?> getPatientByUsername(@PathVariable(name = "username") String username) {
        try {
            Patient patient = service.getPatientByUsername(username);
            return new ResponseEntity<>(patient, HttpStatus.OK);
        } catch (Exception e) {
            throw new PatientNotFound("Patient with that username not found");
        }
    }

    @PostMapping("/reisterPatient")
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
            Map<String, Object> response = new HashMap<>();
            response.put("id", currentPatient.getId());
            response.put("username", currentPatient.getUsername());
            return new ResponseEntity<>(response, HttpStatus.OK);
        }
    }

    @PutMapping("/update")
    public ResponseEntity<?> updatePatient(@RequestBody PatientDto patient) {
        try {
            return service.updatePatient(patient.getGender(), patient.getWeight(), patient.getHeight(),
                    patient.getContactNo(), patient.getContactName(), patient.getId());
        } catch (Exception e) {
            throw new PatientNotFound("Patient database error");
        }
    }

    @DeleteMapping("/delete/{username}")
    public ResponseEntity<?> deletePatient(@PathVariable String username) {
        try {
            service.deletePatient(username);
            return new ResponseEntity<>("Patient deleted", HttpStatus.OK);
        } catch (Exception e) {
            throw new PatientNotFound("Patient database error");
        }
    }

    @GetMapping("/login")
    public ResponseEntity<?> login(@RequestParam String username, @RequestParam String password) {
        try {
            boolean patientfound = service.checkLoginCredentials(username, password);
            return new ResponseEntity<>(patientfound, HttpStatus.OK);
        } catch (Exception e) {
            throw new PatientNotFound("Patient with that username not found");
        }
        //to login go to:
        //http://localhost:8080/patient/login?username=aishwarya&password=BTS
    } 

}
