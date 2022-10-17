package com.example.adminmicroservice.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.adminmicroservice.dto.Doctor;
import com.example.adminmicroservice.dto.DoctorDetails;
import com.example.adminmicroservice.exceptions.DoctorNotFound;
import com.example.adminmicroservice.model.Admin;
import com.example.adminmicroservice.payload.JWTLoginSuccessResponse;
import com.example.adminmicroservice.payload.LoginRequest;
import com.example.adminmicroservice.security.JwtTokenProvider;
import com.example.adminmicroservice.service.AdminService;
import com.example.adminmicroservice.service.DoctorAccountService;
import com.example.adminmicroservice.service.MapValidationErrorService;

import static com.example.adminmicroservice.security.SecurityConstant.TOKEN_PREFIX;

@RestController
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private DoctorAccountService dService;

    @Autowired
    private AdminService aService;

    @Autowired
    private JwtTokenProvider tokenProvider;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private MapValidationErrorService mapValidationErrorService;

    @GetMapping("/listDoctors")
    public List<Doctor> getDoctors() {
        return dService.findAll();
    }

    @GetMapping("/getDoctor/{username}")
    public ResponseEntity<?> getDoctorByUsername(@PathVariable(name = "username") String username) {
        try {
            Doctor doctor = dService.getDoctorByUsername(username);
            return new ResponseEntity<>(doctor, HttpStatus.OK);
        } catch (Exception e) {
            throw new DoctorNotFound("Doctor with that username not found");
        }
    }

    @PostMapping("/createDoctor")
    public ResponseEntity<?> createDoctorAccount(@RequestBody Doctor doctor) {
        if (dService.checkIfUsernameIsFree(doctor)) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", HttpStatus.NOT_ACCEPTABLE);
            response.put("errors", "Username is already taken");
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
            // the patient should have passwords that match to register
        } else {
            // the patient is getting created.
            Doctor currentDoctor = dService.saveDoctor(doctor);
            Map<String, Object> response = new HashMap<>();
            response.put("id", currentDoctor.getId());
            response.put("username", currentDoctor.getUsername());
            return new ResponseEntity<>(true, HttpStatus.OK);
        }

    }

    @PostMapping("/createAdmin")
    public ResponseEntity<?> createAdminAccount(@RequestBody Admin admin) {
        if (aService.checkIfUsernameIsFree(admin)) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", HttpStatus.NOT_ACCEPTABLE);
            response.put("errors", "Username is already taken");
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
            // the patient should have passwords that match to register
        } else {
            // the patient is getting created.
            Admin currentAdmin = aService.saveAdmin(admin);
            Map<String, Object> response = new HashMap<>();
            response.put("id", currentAdmin.getId());
            response.put("username", currentAdmin.getUsername());
            return new ResponseEntity<>(true, HttpStatus.OK);
        }

    }

    @PostMapping("/login")
    public ResponseEntity<?> authenticateUser(@Valid LoginRequest loginRequest, BindingResult result) {
        ResponseEntity<?> errorMap = mapValidationErrorService.MapValidationService(result);
        if (errorMap != null)
            return errorMap;

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.getUsername(),
                        loginRequest.getPassword()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = TOKEN_PREFIX + tokenProvider.generateToken(authentication);
        aService.setAdminToken(jwt, loginRequest.getUsername());
        return ResponseEntity.ok(new JWTLoginSuccessResponse(true, jwt));

    }

    @PutMapping("updateDoctor/{id}")
    public ResponseEntity<?> updateDoctor(@PathVariable int id, @RequestBody DoctorDetails doctorDetails) {
        Doctor updateDoctor = dService.getDoctorById(doctorDetails.getId());
        updateDoctor.setFirstName(doctorDetails.getFirstName());
        updateDoctor.setLastName(doctorDetails.getLastName());
        updateDoctor.setEmail(doctorDetails.getEmail());
        updateDoctor.setUsername(doctorDetails.getUsername());

        dService.saveDoctor(updateDoctor);

        return ResponseEntity.ok(updateDoctor);
    }

    @DeleteMapping("/deleteDoctor/{username}")
    public ResponseEntity<?> deleteDoctor(@PathVariable(name = "username") String username) {
        try {
            dService.deleteDoctor(username);
            return new ResponseEntity<>("Doctor deleted", HttpStatus.OK);
        } catch (Exception e) {
            throw new DoctorNotFound("Doctor with that username not found");
        }
    }

}
