package com.sept.telemedicine.service;

import com.sept.telemedicine.model.Patient;
import com.sept.telemedicine.repository.PatientRepository;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.List;
import java.util.Optional;

@Service
public class PatientService {

    @Autowired
    private PatientRepository repo;

    private BCryptPasswordEncoder bCryptPasswordEncoder;

    public Patient findById(Integer id) {
        return repo.findById(id).orElse(null);
    }

    public List<Patient> findAll() {
        return repo.findAll();
    }

    public void savePatient(Patient patient) {
        patient.setPassword(bCryptPasswordEncoder.encode(patient.getPassword()));
        patient.setUsername(patient.getUsername());
        patient.setConfirmPassword("");
        repo.save(patient);

    }

    public Optional<Patient> getPatientByUsername(String username) {
        Integer id = repo.findIdByUsername(username);
        return repo.findById(id);
    }

    public boolean checkIfUsernameIsTaken(Patient patient) {
        return repo.findUsername(patient.getUsername()) != null;
    }

    public void deletePatient(int id) {
        repo.deleteById(id);
    }

    public void updatePatient(String gender, double weight, double height, String contactNo, String contactName,
            int id) {
        repo.updateDetails(gender, weight, height, contactNo, contactName, id);
    }

    public Integer findIdByUsername(String username) {
        return repo.findIdByUsername(username);
    }

}
