package com.sept.doctor.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sept.doctor.exceptions.DoctorNotFound;
import com.sept.doctor.model.Doctor;
import com.sept.doctor.service.DoctorService;

@RestController
@RequestMapping("/doctor")
public class DoctorController {

    @Autowired
    private DoctorService service;

    @GetMapping("/list")
    public List<Doctor> getDoctors() {
        return service.findAll();
    }

    @GetMapping("/getBy/{username}")
    public ResponseEntity<?> getDoctorByUsername(@PathVariable(name = "username") String username) {
        try {
            Doctor doctor = service.getDoctorByUsername(username);
            return new ResponseEntity<>(doctor, HttpStatus.OK);
        } catch (Exception e) {
            throw new DoctorNotFound("Doctor with that username not found");
        }
    }

    @PostMapping("/register")
    public ResponseEntity<?> registerDoctor(@RequestParam String username, @RequestParam String password,
            @RequestParam String confirmPassword, @RequestParam String firstName,
            @RequestParam String lastName, @RequestParam String email) {

        Doctor doctor = new Doctor(username, password, firstName, lastName, email);

        if (service.checkIfUsernameIsFree(doctor)) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", HttpStatus.NOT_ACCEPTABLE);
            response.put("errors", "Username is already taken");
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
            // the patient should have passwords that match to register
        } else if (!doctor.getPassword().equals(doctor.getConfirmPassword())) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", HttpStatus.NOT_ACCEPTABLE);
            response.put("errors", "Your both passwords should be same.");
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        } else {
            // the patient is getting created.
            Doctor currentDoctor = service.saveDoctor(doctor);
            Map<String, Object> response = new HashMap<>();
            response.put("id", currentDoctor.getId());
            response.put("username", currentDoctor.getUsername());
            return new ResponseEntity<>(true, HttpStatus.OK);
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestParam String username, @RequestParam String password) {
        try {
            boolean doctorfound = service.checkLoginCredentials(username, password);
            return new ResponseEntity<>(doctorfound, HttpStatus.OK);
        } catch (Exception e) {
            throw new DoctorNotFound("Patient with that username not found");
        }
        // to login go to:
        // http://localhost:8080/patient/login?username=Suga&password=Taehyung
    }

}
