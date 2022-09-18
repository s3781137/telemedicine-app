package com.sept.telemedicine.api;

import com.mysql.cj.protocol.x.Ok;
import com.sept.telemedicine.Validator.UserValidator;
import com.sept.telemedicine.dto.PatientDto;
import com.sept.telemedicine.exceptions.PatientNotFound;
import com.sept.telemedicine.model.Patient;
//import com.sept.telemedicine.model.PatientHealthInformation;
import com.sept.telemedicine.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.validation.BindingResult;
import com.sept.telemedicine.service.MapValidationErrorService;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/patient")
public class PatientController {

    @Autowired
    private PatientService service;

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private MapValidationErrorService mapValidationErrorService;

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

    @PostMapping("/registerPatient")
    public ResponseEntity<?> addPatient(@RequestBody Patient patient, BindingResult result) {
        userValidator.validate(patient, result);

        ResponseEntity<?> errorMap = mapValidationErrorService.MapValidationService(result);
        if(errorMap != null)return errorMap;

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

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestParam String username, @RequestParam String password) {
        try {
            boolean patientfound = service.checkLoginCredentials(username, password);
            return new ResponseEntity<>(patientfound, HttpStatus.OK);
        } catch (Exception e) {
            throw new PatientNotFound("Patient with that username not found");
        }
        //to login go to:
        //http://localhost:8080/patient/login?username=Suga&password=Taehyung
    } 

    // @PostMapping("/patientHealthInfo")
    // public ResponseEntity<?> addPatientHealthInfo(@RequestBody PatientHealthInformation healthInfo) {
    //      {
    //         PatientHealthInformation currentPatientHealthInfo = service.savePatientHealthInfo(healthInfo);
    //         Map<String, Object> response = new HashMap<>();
    //         response.put("id", currentPatientHealthInfo.getId());
    //         response.put("message", "health information registered" );
    //         return new ResponseEntity<>(response, HttpStatus.OK);
    //     }
    // } 

    // @PutMapping("/updateHealthInfo")
    // public ResponseEntity<?> updateHealthInfo(@RequestBody PatientHealthInformation healthInfo) {
    //     try {
    //          service.updateHealthInfo(healthInfo);
    //          Map<String, Object> response = new HashMap<>();
    //          response.put("id", healthInfo.getId());
    //          response.put("message", "health information registered" );
    //          return new ResponseEntity<>(response, HttpStatus.OK);

    //     } catch (Exception e) {
    //         throw new PatientNotFound("Patient database error");
    //     }
    // }
}
