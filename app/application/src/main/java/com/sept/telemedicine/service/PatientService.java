package com.sept.telemedicine.service;

import com.sept.telemedicine.model.Patient;
import com.sept.telemedicine.model.PatientHealthInformation;
import com.sept.telemedicine.repository.PatientHealthRepository;
import com.sept.telemedicine.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PatientService {

    @Autowired
    private PatientRepository repo;

    @Autowired
    private PatientHealthRepository healthRepo;

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

    public void deletePatient(String username) {
        int id = repo.findIdByUsername(username);
        repo.deleteById(id);
    }

    public ResponseEntity<?> updatePatient(String gender, double weight, double height, String contactNo,
            String contactName,
            int id) {
        Optional<Patient> patient = repo.findById(id);
        if (patient.isPresent()) {
            patient.get().setGender(gender);
            patient.get().setWeight(weight);
            patient.get().setHeight(height);
            patient.get().setContactNo(contactNo);
            patient.get().setContactName(contactName);
            Patient updatedPatient = repo.save(patient.get());
            return new ResponseEntity<>(updatedPatient, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("There is no patient with this ID", HttpStatus.OK);
        }
    }

    public Integer findIdByUsername(String username) {
        return repo.findIdByUsername(username);
    }

    public boolean checkLoginCredentials(String username, String password) {
        Optional<Patient> existingPatient = repo.findPatientByUsername(username);
        if (existingPatient.isPresent()) {
            return bCryptPasswordEncoder.matches(password, repo.findPasswordByUsername(username));

        }
        return false;
    }

    public PatientHealthInformation createPatientHealthInfo(int id) {
        PatientHealthInformation newInfo = new PatientHealthInformation();
        newInfo.setId(id);
        newInfo.setCancer("negative");
        newInfo.setDiabetes("negative");
        newInfo.setHeartDisease("negative");
        newInfo.setKidneyDisease("negative");
        newInfo.setLiverDisease("negative");
        newInfo.setMedicalProblems("none");
        newInfo.setMedication("none");
        newInfo.setMedicationDescription("none");
        newInfo.setPastSurgeries("none");
        return healthRepo.save(newInfo);
    }

    public void updateHealthInfo(PatientHealthInformation healthInfo) {
        healthRepo.save(healthInfo);

    }

    public Optional<PatientHealthInformation> getHealthInfo(int id) {
        return healthRepo.findById(id);
    }
}
