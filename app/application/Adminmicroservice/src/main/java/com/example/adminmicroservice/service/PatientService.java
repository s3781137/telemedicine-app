package com.example.adminmicroservice.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.adminmicroservice.dto.Patient;
import com.example.adminmicroservice.repository.PatientRepository;

@Service
public class PatientService {

    @Autowired
    private PatientRepository repo;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    // getting a patient by id from the repo
    public Patient findById(Integer id) {
        return repo.findById(id).orElse(null);
    }

    // get all patients from the epo
    public List<Patient> findAll() {
        return repo.findAll();
    }

    // saving a patient in the repo
    public Patient savePatient(Patient patient) {
        patient.setPassword(bCryptPasswordEncoder.encode(patient.getPassword()));
        patient.setUsername(patient.getUsername());
        patient.setConfirmPassword(bCryptPasswordEncoder.encode(patient.getConfirmPassword()));
        return repo.save(patient);

    }

    // getting a patient by username from the repo
    public Patient getPatientByUsername(String username) {
        Optional<Patient> patient = repo.findPatientByUsername(username);
        if (patient.isPresent()) {
            return patient.get();
        } else {
            throw new RuntimeException("There is no patient against this username: " + username);
        }
    }

    // checking if a username already exists in the repo
    public boolean checkIfUsernameIsFree(Patient patient) {
        Optional<Patient> existingPatient = repo.findPatientByUsername(patient.getUsername());
        return existingPatient.isPresent();
    }

    // removing a patient from the repo
    public void deletePatient(String username) {
        int id = repo.findIdByUsername(username);
        repo.deleteById(id);
    }

    // getting the patient id by username from the repo
    public Integer findIdByUsername(String username) {
        return repo.findIdByUsername(username);
    }

    // checking if the login credentials match the login credintials in the repo
    public boolean checkLoginCredentials(String username, String password) {
        Optional<Patient> existingPatient = repo.findPatientByUsername(username);
        if (existingPatient.isPresent()) {
            return bCryptPasswordEncoder.matches(password, repo.findPasswordByUsername(username));

        }
        return false;
    }

}
