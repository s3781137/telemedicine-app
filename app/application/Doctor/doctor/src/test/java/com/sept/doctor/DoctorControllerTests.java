// package com.sept.doctor;

// import java.util.List;

// import org.junit.jupiter.api.*;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.test.annotation.Rollback;
// import org.springframework.test.context.junit4.SpringRunner;

// import com.sept.doctor.api.*;
// import com.sept.doctor.model.*;
// import com.sept.doctor.repository.*;
// import com.sept.doctor.service.DoctorService;

// import org.springframework.boot.test.context.SpringBootTest;
// import org.springframework.boot.test.mock.mockito.MockBean;

// @SpringBootTest
// public class DoctorControllerTests {
//     @Autowired
//     private DoctorService service;

//     @Test
//     public void testregisterDoctor() throws RuntimeException{
//         Doctor d = new Doctor("Dr Kim", "password", "password", "Kim", "Seokjin", "kim@gmail.com");
//         Assertions.assertNotNull(service.saveDoctor(d));
//     }

//     @Test
//     public void testListDoctor() throws RuntimeException{
//         Doctor d = new Doctor("Dr Kim", "password", "password", "Kim", "Seokjin", "kim@gmail.com");
//         Doctor d1 = new Doctor("Dr Yoongi", "Min", "Min", "Kim", "Seokjin", "Min@gmail.com");
//         service.saveDoctor(d);
//         service.saveDoctor(d1);
//         Assertions.assertNotNull(service.findAll());
//     }

//     @Test
//     public void usernameExistsRegistration() {
//         Doctor d = new Doctor("Dr new name", "password", "password", "Kim", "Seokjin", "kim@gmail.com");

//         Assertions.assertFalse(service.checkIfUsernameIsFree(d));
//     }


//     @Test
//     public void testGetNotExistingDoctor() throws RuntimeException {
//         Assertions.assertThrows(RuntimeException.class, () -> {
//             service.getDoctorByUsername("idonotexist");
//         });

//     }

//     @Test void testDeleteDoctor() throws RuntimeException{
//         Doctor d = new Doctor("Dr Kedrick Lamar", "password", "password", "Kim", "Seokjin", "kim@gmail.com");
//         d = service.saveDoctor(d);
        
//         Assertions.assertTrue(service.deleteDoctor(d.getUsername()));

//     }

    

    
// }
