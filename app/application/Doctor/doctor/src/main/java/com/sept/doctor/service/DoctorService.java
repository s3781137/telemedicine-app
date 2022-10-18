package com.sept.doctor.service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import org.springframework.data.util.Pair;
import com.sept.doctor.model.Doctor;
import com.sept.doctor.repository.DoctorRepository;

@Service
public class DoctorService {

    @Autowired
    private DoctorRepository repo;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    // get doctor account by id
    public Doctor getDoctorById(Integer id) {
        return repo.findById(id).get();
    }

    // return all doctors accounts in database
    public List<Doctor> findAll() {
        return repo.findAll();
    }

    // save doctor account in database
    public Doctor saveDoctor(Doctor doctor) {
        doctor.setPassword(bCryptPasswordEncoder.encode(doctor.getPassword()));
        doctor.setUsername(doctor.getUsername());
        doctor.setConfirmPassword(bCryptPasswordEncoder.encode(doctor.getConfirmPassword()));
        return repo.save(doctor);
    }

    // get doctor by username
    public Doctor getDoctorByUsername(String username) {
        Optional<Doctor> doctor = repo.findDoctorByUsername(username);
        if (doctor.isPresent()) {
            return doctor.get();
        } else {
            throw new RuntimeException("There is no doctor against this username: " + username);
        }
    }

    // check if username is taken in database
    public boolean checkIfUsernameIsFree(Doctor doctor) {
        Optional<Doctor> existingDoctor = repo.findDoctorByUsername(doctor.getUsername());
        return existingDoctor.isPresent();
    }

    // delete doctor account by username
    public boolean deleteDoctor(String username) {
        int id = repo.findIdByUsername(username);
        repo.deleteById(id);
        return true;
    }

    // find id by username
    public Integer findIdByUsername(String username) {
        return repo.findIdByUsername(username);
    }

    // checks if login credentials are correct
    public boolean checkLoginCredentials(String username, String password) {
        Optional<Doctor> existingDoctor = repo.findDoctorByUsername(username);
        if (existingDoctor.isPresent()) {
            return bCryptPasswordEncoder.matches(password, repo.findPasswordByUsername(username));

        }
        return false;
    }

    // check if passwords match
    public boolean doPasswordsMatch(String hashedPassword, String plainTextPassword) {
        return bCryptPasswordEncoder.matches(plainTextPassword, hashedPassword);
    }

    // returns doctor exists by username and matches password
    public boolean comparePassword(String username, String plainTextPassword) {
        Optional<Doctor> doctor = repo.findDoctorByUsername(username);
        return (doctor.isPresent() && doPasswordsMatch(doctor.get().getPassword(), plainTextPassword));
    }

    // login as doctor
    public Pair<Optional<String>, Optional<Doctor>> login(String username, String plainTextPassword) {
        Optional<Doctor> doctorOptional = repo.findDoctorByUsername(username);

        Optional<String> token = Optional.empty();
        if (comparePassword(username, plainTextPassword)) {
            token = Optional.of(UUID.randomUUID().toString());
            Doctor doctor = doctorOptional.get();
            doctor.setToken(token.get());
        }
        return Pair.of(token, doctorOptional);
    }

    // set jwt of doctor
    public void setDoctorToken(String token, String username) {
        repo.setToken(token, username);

    }

}
