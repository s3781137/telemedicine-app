package com.sept.telemedicine.api;

import com.mysql.cj.protocol.x.Ok;
import com.sept.telemedicine.Validator.UserValidator;
import com.sept.telemedicine.dto.PatientDto;
import com.sept.telemedicine.exceptions.PatientNotFound;
import com.sept.telemedicine.model.Patient;
import com.sept.telemedicine.model.PatientHealthInformation;
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

import javax.naming.Binding;

@RestController
@RequestMapping("/patient") //all the patient queries will have to be followed bythe /patient in the url
public class PatientController {

    @Autowired
    private PatientService service;

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private MapValidationErrorService mapValidationErrorService;

    //this list method will get all the patients that are present in the database
    //the url http://localhost:8080/patient/list will list all the patients.
    @GetMapping("/list")
    public List<Patient> getPatients() {
        return service.findAll();
    }

    //the getPatientByUsername method will get a particular patient's details from the database. 
    // If suga is registered username then http://localhost:8080/patient/Suga 
    //will return all the details for a patient with name Suga.
    @GetMapping("/getBy/{username}")
    public ResponseEntity<?> getPatientByUsername(@PathVariable(name = "username") String username) {
        try {
            Patient patient = service.getPatientByUsername(username);
            return new ResponseEntity<>(patient, HttpStatus.OK);
        } catch (Exception e) {
            throw new PatientNotFound("Patient with that username not found");
        }
    }
    //This method creates a patient in the database. The required parameters
    // to create a patient inclue a name, password, confirmpassword, firstName,
    // lastName and email. The passwords must match for the account to be created.
    //the id for each patient is automatically generated in the database. 
    // to register a patient http://localhost:8080/patient/registerPatient 
    @PostMapping("/registerPatient")
    public ResponseEntity<?> addPatient( @RequestParam String username,
            @RequestParam String password,
            @RequestParam String confirmPassword, @RequestParam String firstName,
            @RequestParam String lastName, @RequestParam String email) {
        // @RequestBody Patient patient

        Patient patient = new Patient(username, password, confirmPassword, firstName, lastName, email);
        // userValidator.validate(patient, result);

        // ResponseEntity<?> errorMap =
        // mapValidationErrorService.MapValidationService(result);
        // if(errorMap != null)return errorMap;


        //a patient should have a unique username to be registered
        if (service.checkIfUsernameIsFree(patient)) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", HttpStatus.NOT_ACCEPTABLE);
            response.put("errors", "Username is already taken");
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        //the patient should have passwords that match to register
        } else if (!patient.getPassword().equals(patient.getConfirmPassword())) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", HttpStatus.NOT_ACCEPTABLE);
            response.put("errors", "Your both passwords should be same.");
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        } else {
            //the patient is getting created. 
            Patient currentPatient = service.savePatient(patient);
            service.createPatientHealthInfo(currentPatient.getId());
            Map<String, Object> response = new HashMap<>();
            response.put("id", currentPatient.getId());
            response.put("username", currentPatient.getUsername());
            return new ResponseEntity<>(true, HttpStatus.OK);
        }

    }

    //this put mappig method will update the details of the users present in the database
    //The only fields that a user can update are gender, weight, height, number and name. 
    @PutMapping("/update")
    public ResponseEntity<?> updatePatient(@RequestBody PatientDto patient) {
        try {
            return service.updatePatient(patient.getGender(), patient.getWeight(), patient.getHeight(),
                    patient.getContactNo(), patient.getContactName(), patient.getId());
        } catch (Exception e) {
            //if the patient details are incorrect or if there is no existing patient
            throw new PatientNotFound("Patient database error");
        }
    }

    //this method will remove a user from the database through delete mapping.
    // user can be deleted thorugh specifying the unique username. 
    // to delete a patient http://localhost:8080/patient/delete/suga
    @DeleteMapping("/delete/{username}")
    public ResponseEntity<?> deletePatient(@PathVariable String username) {
        try {
            service.deletePatient(username);
            return new ResponseEntity<>("Patient deleted", HttpStatus.OK);
        } catch (Exception e) {
            throw new PatientNotFound("Patient database error");
        }
    }

    //this postMapping method is used to login a user. The patient can only login
    //with valid credientials.
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestParam String username, @RequestParam String password) {
        try {
            boolean patientfound = service.checkLoginCredentials(username, password);
            return new ResponseEntity<>(patientfound, HttpStatus.OK);
        } catch (Exception e) {
            throw new PatientNotFound("Patient with that username not found");
        }
        // to login go to:
        // http://localhost:8080/patient/login?username=Suga&password=Taehyung
    }

    //This method is used to update a patient's health information
    //the patient can go to http://localhost:8080/patient/updateHealthInfo and 
    //specify their id to update their diseases.
    @PutMapping("/updateHealthInfo")
    public ResponseEntity<?> updateHealthInfo(@RequestBody PatientHealthInformation healthInfo) {
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
