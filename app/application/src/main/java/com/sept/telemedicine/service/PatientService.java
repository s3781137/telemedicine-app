package com.sept.telemedicine.service;

import com.sept.telemedicine.model.Patient;
import com.sept.telemedicine.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PatientService {

    @Autowired
    private PatientRepository repo;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    public Patient findById(Integer id) {
        return repo.findById(id).orElse(null);
    }

    public List<Patient> findAll() {
        return repo.findAll();
    }

    public Patient savePatient(Patient patient) {
        patient.setPassword(bCryptPasswordEncoder.encode(patient.getPassword()));
        patient.setUsername(patient.getUsername());
        patient.setConfirmPassword(bCryptPasswordEncoder.encode(patient.getConfirmPassword()));
        return repo.save(patient);

    }

    public Patient getPatientByUsername(String username) {
        Optional<Patient> patient = repo.findPatientByUsername(username);
        if (patient.isPresent()) {
            return patient.get();
        } else {
            throw new RuntimeException("There is no patient against this username: " + username);
        }
    }

    public boolean checkIfUsernameIsFree(Patient patient) {
        Optional<Patient> existingPatient = repo.findPatientByUsername(patient.getUsername());
        return existingPatient.isPresent();
    }

    public void deletePatient(int id) {
        repo.deleteById(id);
    }

    public void updatePatient(String status, String gender, double weight, double height, String contactNo,
            String contactName,
            int id) {
        repo.updateDetails(status, gender, weight, height, contactNo, contactName, id);
    }

    public Integer findIdByUsername(String username) {
        return repo.findIdByUsername(username);
    }
}
