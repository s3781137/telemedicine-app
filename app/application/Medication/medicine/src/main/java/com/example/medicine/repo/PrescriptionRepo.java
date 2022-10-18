package com.example.medicine.repo;


import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.medicine.model.Prescription;



@Repository
public interface PrescriptionRepo extends JpaRepository<Prescription, Integer>  {

    //selects all the prescriptions for a patient
    @Query("Select p from Prescription p where patientUsername=?1")
    public List<Prescription> findPrescriptionByPatientUsername(String patientUsername);

    //finds a particular prescription
    @Query("Select p from Prescription p where p.doctorUsername=?1 and p.patientUsername=?2 and p.medicine=?3")
    public Prescription findPrescription(String getdoctorUsername, String getpatientUsername, String medicine);
    
}

