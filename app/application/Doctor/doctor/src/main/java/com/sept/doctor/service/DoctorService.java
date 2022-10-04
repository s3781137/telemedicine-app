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

    public Doctor getDoctorById(Integer id) {
        return repo.findById(id).get();
    }

    public List<Doctor> findAll() {
        return repo.findAll();
    }

    public Doctor saveDoctor(Doctor doctor) {
        doctor.setPassword(bCryptPasswordEncoder.encode(doctor.getPassword()));
        doctor.setUsername(doctor.getUsername());
        doctor.setConfirmPassword(bCryptPasswordEncoder.encode(doctor.getConfirmPassword()));
        return repo.save(doctor);
    }

    public Doctor getDoctorByUsername(String username) {
        Optional<Doctor> doctor = repo.findDoctorByUsername(username);
        if (doctor.isPresent()) {
            return doctor.get();
        } else {
            throw new RuntimeException("There is no doctor against this username: " + username);
        }
    }

    public boolean checkIfUsernameIsFree(Doctor doctor) {
        Optional<Doctor> existingDoctor = repo.findDoctorByUsername(doctor.getUsername());
        return existingDoctor.isPresent();
    }

    public void deleteDoctor(String username) {
        int id = repo.findIdByUsername(username);
        repo.deleteById(id);
    }

    public Integer findIdByUsername(String username) {
        return repo.findIdByUsername(username);
    }

    public boolean checkLoginCredentials(String username, String password) {
        Optional<Doctor> existingDoctor = repo.findDoctorByUsername(username);
        if (existingDoctor.isPresent()) {
            return bCryptPasswordEncoder.matches(password, repo.findPasswordByUsername(username));

        }
        return false;
    }

    public boolean doPasswordsMatch(String hashedPassword, String plainTextPassword) {
        return bCryptPasswordEncoder.matches(plainTextPassword, hashedPassword);
    }

    public boolean comparePassword(String username, String plainTextPassword) {
        Optional<Doctor> doctor = repo.findDoctorByUsername(username);
        return (doctor.isPresent() && doPasswordsMatch(doctor.get().getPassword(), plainTextPassword));
    }

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

    public void setDoctorToken(String token, String username) {
        repo.setToken(token, username);

    }

}
