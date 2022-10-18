package com.example.medicine.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.medicine.model.Prescription;
import com.example.medicine.repo.PrescriptionRepo;


@Service
public class PrescriptionService {

    @Autowired
    private PrescriptionRepo repo;

    //lists all the precriptions
    public List<Prescription> findAll(){
        return repo.findAll();
    }

    //finds a prescription by username
    public List<Prescription> findAllByName(String patientUsername) {
        return repo.findPrescriptionByPatientUsername(patientUsername);
    }

    //adds a prescription to the database
    public Prescription savePrescription(Prescription p) {
        return repo.save(p);
    }

    //removes a prescription form the databadse
    public boolean removePrescription(Prescription p) {
        Prescription pre=repo.findPrescription(p.getdoctorUsername(),p.getpatientUsername(),p.getMedicine());
        repo.delete(pre);
        return true;
    }
    
}
