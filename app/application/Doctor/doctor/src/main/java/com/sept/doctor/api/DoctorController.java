package com.sept.doctor.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.util.Pair;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sept.doctor.exceptions.DoctorNotFound;
import com.sept.doctor.model.Doctor;
import com.sept.doctor.payload.JWTLoginSuccessResponse;
import com.sept.doctor.payload.LoginRequest;
import com.sept.doctor.security.JwtTokenProvider;
import com.sept.doctor.service.DoctorService;
import com.sept.doctor.service.MapValidationErrorService;
import com.sept.doctor.validator.DoctorValidator;

import static com.sept.doctor.security.SecurityConstant.TOKEN_PREFIX;

@RestController
@RequestMapping("/doctor")
public class DoctorController {

    @Autowired
    private DoctorService service;

    @Autowired
    private JwtTokenProvider tokenProvider;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private MapValidationErrorService mapValidationErrorService;

    @Autowired
    private DoctorValidator doctorValidator;

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

    // @PostMapping("/register")
    // public ResponseEntity<?> registerDoctor(@RequestParam String username,
    // @RequestParam String password,
    // @RequestParam String confirmPassword, @RequestParam String firstName,
    // @RequestParam String lastName, @RequestParam String email) {

    // Doctor doctor = new Doctor(username, password, firstName, lastName, email);

    // if (service.checkIfUsernameIsFree(doctor)) {
    // Map<String, Object> response = new HashMap<>();
    // response.put("status", HttpStatus.NOT_ACCEPTABLE);
    // response.put("errors", "Username is already taken");
    // return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    // // the patient should have passwords that match to register
    // } else if (!doctor.getPassword().equals(doctor.getConfirmPassword())) {
    // Map<String, Object> response = new HashMap<>();
    // response.put("status", HttpStatus.NOT_ACCEPTABLE);
    // response.put("errors", "Your both passwords should be same.");
    // return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    // } else {
    // // the patient is getting created.
    // Doctor currentDoctor = service.saveDoctor(doctor);
    // Map<String, Object> response = new HashMap<>();
    // response.put("id", currentDoctor.getId());
    // response.put("username", currentDoctor.getUsername());
    // return new ResponseEntity<>(true, HttpStatus.OK);
    // }
    // }

    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@Valid @RequestBody Doctor doctor, BindingResult result) {
        // Validate passwords match
        doctorValidator.validate(doctor, result);

        ResponseEntity<?> errorMap = mapValidationErrorService.MapValidationService(result);
        if (errorMap != null)
            return errorMap;

        Doctor newDoctor = service.saveDoctor(doctor);

        return new ResponseEntity<Doctor>(newDoctor, HttpStatus.CREATED);
    }

    @PostMapping("/login")
    public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest, BindingResult result) {
        ResponseEntity<?> errorMap = mapValidationErrorService.MapValidationService(result);
        if (errorMap != null)
            return errorMap;

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.getUsername(),
                        loginRequest.getPassword()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = TOKEN_PREFIX + tokenProvider.generateToken(authentication);

        return ResponseEntity.ok(new JWTLoginSuccessResponse(true, jwt));
    }

    @DeleteMapping("/delete/{username}")
    public ResponseEntity<?> deleteDoctor(@PathVariable(name = "username") String username) {
        try {
            service.deleteDoctor(username);
            return new ResponseEntity<>("Doctor deleted", HttpStatus.OK);
        } catch (Exception e) {
            throw new DoctorNotFound("Doctor with that username not found");
        }
    }

    // @PutMapping("/token")
    // public ResponseEntity<Map> getToken(@RequestParam String username, String
    // password) {
    // Map<String, Object> response = new HashMap<>();
    // response.put("username", username);
    // Pair<Optional<String>, Optional<Doctor>> loginResult =
    // service.login(username, password);
    // if (loginResult.getFirst().isPresent()) {
    // response.put("status", "successful");
    // response.put("token", loginResult.getFirst().get());
    // if (loginResult.getSecond().isPresent()) {
    // response.put("user", loginResult.getSecond().get());
    // }

    // return new ResponseEntity<>(response, HttpStatus.OK);
    // } else {
    // response.put("status", "failed");
    // response.put("token", null);
    // return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    // }
    // }

}
