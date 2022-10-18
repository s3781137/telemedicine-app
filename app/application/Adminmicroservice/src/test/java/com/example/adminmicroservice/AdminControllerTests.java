// package com.example.adminmicroservice;

// import org.junit.jupiter.api.Assertions;
// import org.junit.jupiter.api.Test;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.boot.SpringBootConfiguration;
// import org.springframework.boot.test.context.SpringBootTest;
// import org.springframework.test.context.ContextConfiguration;

// import com.example.adminmicroservice.dto.Doctor;
// import com.example.adminmicroservice.dto.DoctorDetails;
// import com.example.adminmicroservice.dto.Patient;
// import com.example.adminmicroservice.dto.PatientDetails;
// import com.example.adminmicroservice.model.Admin;
// import com.example.adminmicroservice.service.AdminService;
// import com.example.adminmicroservice.service.DoctorAccountService;
// import com.example.adminmicroservice.service.PatientService;

// @ContextConfiguration(classes = AdminmicroserviceApplication.class)
// @SpringBootTest
// public class AdminControllerTests {

//     @Autowired
//     private AdminService aService;

//     @Autowired
//     private DoctorAccountService doctorService;

//     @Autowired
//     private PatientService patientService;

//     @Test
//     public void createAdminTest() {
//         Admin admin = new Admin("test", "test", "test");
//         Assertions.assertNotNull(aService.saveAdmin(admin));
//     }

//     @Test
//     public void createPatientTest() {
//         Patient patient = new Patient("test123", "test123", "test123", "test", "ing", "test@test.com");
//         Assertions.assertNotNull(patientService.savePatient(patient));
//     }

//     @Test
//     public void createDoctorTest() {
//         Doctor doctor = new Doctor("test123", "test123", "test", "test", "test@test.com");
//         Assertions.assertNotNull(doctorService.saveDoctor(doctor));
//     }

//     @Test
//     public void getPatientTest() {
//         Assertions.assertNotNull(patientService.getPatientByUsername("test123"));
//     }

//     @Test
//     public void getDoctorTest() {
//         Assertions.assertNotNull(doctorService.getDoctorByUsername("test123"));
//     }

//     @Test
//     public void updateDoctorTest() {
//         DoctorDetails doctorDetails = new DoctorDetails(97, "changedname", "changedemail", "changedfirst",
//                 "changedlast");

//         Doctor updateDoctor = doctorService.getDoctorById(doctorDetails.getId());
//         updateDoctor.setFirstName(doctorDetails.getFirstName());
//         updateDoctor.setLastName(doctorDetails.getLastName());
//         updateDoctor.setEmail(doctorDetails.getEmail());
//         updateDoctor.setUsername(doctorDetails.getUsername());

//         doctorService.saveDoctor(updateDoctor);
//         Assertions.assertNotNull(doctorService.getDoctorByUsername("changedname"));

//     }

//     @Test
//     public void updatePatientTest() {
//         PatientDetails patientDetails = new PatientDetails(114, "changedname", "changedemail", "changedfirst",
//                 "changedlast");
//         Patient updatePatient = patientService.findById(patientDetails.getId());
//         updatePatient.setFirstName(patientDetails.getFirstName());
//         updatePatient.setLastName(patientDetails.getLastName());
//         updatePatient.setEmail(patientDetails.getEmail());
//         updatePatient.setUsername(patientDetails.getUsername());

//         patientService.savePatient(updatePatient);
//         Assertions.assertNotNull(patientService.getPatientByUsername("changedname"));
//     }

//     @Test
//     public void deletePatientTest() {

//         Assertions.assertThrows(NullPointerException.class, () -> {
//             patientService.deletePatient("changedname");
//         }, "null");
//     }

//     @Test
//     public void deleteDoctorTest() {

//         Assertions.assertThrows(NullPointerException.class, () -> {
//             doctorService.deleteDoctor("changedname");
//         }, "null");
//     }
// }
