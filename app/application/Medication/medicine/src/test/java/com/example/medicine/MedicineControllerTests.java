package com.example.medicine;

import java.util.List;

import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;

import com.example.medicine.service.PrescriptionService;
import com.example.medicine.api.*;
import com.example.medicine.model.*;
import com.example.medicine.repo.*;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

//this class is used to test the backend functionality
@SpringBootTest
public class MedicineControllerTests {

    @Autowired
    private PrescriptionService service;



    @Test
    public void testAddPrescription() throws RuntimeException {
        Prescription p = new Prescription("Dr jungkook", "Taehynung", "Panadol");
        Assertions.assertNotNull(service.savePrescription(p));

    }

    @Test
    public void testPrescriptionByPatient() throws RuntimeException {
        Prescription p = new Prescription("Dr Kim", "Taehynung", "Panadol");
        service.savePrescription(p);
        List<Prescription>pre = service.findAllByName("Taehynung");
        Assertions.assertNotNull(pre);
        Assertions.assertEquals(pre.get(0).getMedicine(), "Panadol");      

    }

    @Test
    public void testDeletePrescription() throws RuntimeException{
        Prescription p = new Prescription("Dr Namjoon", "Jimin", "Ibuprofin");
        service.savePrescription(p);
        Assertions.assertTrue(service.removePrescription(p));
    }
   
 

}
