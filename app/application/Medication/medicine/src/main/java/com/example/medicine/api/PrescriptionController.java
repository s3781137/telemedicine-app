package com.example.medicine.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.medicine.exception.PrescriptionNotFound;
import com.example.medicine.model.Prescription;
import com.example.medicine.service.PrescriptionService;


@RestController
@RequestMapping("/prescription")
public class PrescriptionController {

    @Autowired
    private PrescriptionService service;

    //lists all the precriptions for a patient
    @GetMapping("/view")
        public List<Prescription> getPrescriptionByPatient(String patientUsername) {
            try{
            return service.findAllByName(patientUsername);
            } catch(Exception e){
                throw new PrescriptionNotFound("Prescription not found for this patient");
            }
    }


    //adds a prescription for a patient
    @PostMapping("/addPrescription")
    public ResponseEntity<?> addPrescription(@RequestBody Prescription p) {
        try{
            p=service.savePrescription(p);
            Map<String, Object> response = new HashMap<>();
            response.put("id", p.getId());
            response.put("message", "prescription added");
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e){
            throw e;
        }
    }

    //delets a patient's prescription
    @DeleteMapping("deletePrescription")
    public ResponseEntity<?> deletePrescription(@RequestBody Prescription p) {
        try{
        service.removePrescription(p);
        Map<String, Object> response = new HashMap<>();
        response.put("id", p.getId());
        response.put("message", "prescription deleted");
        return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e){
            throw new PrescriptionNotFound("This prescription does not exist");
        }
}



    
}
