package com.sept.telemedicine.service;

import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import com.sept.telemedicine.model.PatientHealthInfo;
import com.sept.telemedicine.repository.PatientHealthRepository;

@Service
public class PatientHealthService {

    @Autowired
    private PatientHealthRepository healthRepo;

    public PatientHealthInfo findById(Integer id) {
        return healthRepo.findById(id).orElse(null);
    }

    public PatientHealthInfo createPatientHealthInfo(PatientHealthInfo newInfo) {
        return healthRepo.save(newInfo);

    }

    public ResponseEntity<?> updatePatientHealth(int id, String cancer,
            String diabetes,
            String heartDisease,
            String kidneyDisease, String liverDisease,
            String medicalProblems, String medication, String medicationDescription, String pastSurgeries) {

        Optional<PatientHealthInfo> phi = healthRepo.findById(id);
        if (phi.isPresent()) {
            phi.get().setCancer(cancer);
            phi.get().setDiabetes(diabetes);
            phi.get().setHeartDisease(heartDisease);
            phi.get().setKidneyDisease(kidneyDisease);
            phi.get().setLiverDisease(liverDisease);
            phi.get().setMedicalProblems(medicalProblems);
            phi.get().setMedication(medication);
            phi.get().setMedicationDescription(medicationDescription);
            phi.get().setPastSurgeries(pastSurgeries);
            PatientHealthInfo updatedDetails = healthRepo.save(phi.get());
            return new ResponseEntity<>(updatedDetails, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("Invalid ID", HttpStatus.OK);
        }
    }
}
