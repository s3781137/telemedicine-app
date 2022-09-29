package com.sept.telemedicine;

import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;

import com.sept.telemedicine.dto.PatientDto;
import com.sept.telemedicine.model.Patient;
import com.sept.telemedicine.model.PatientHealthInformation;
import com.sept.telemedicine.repository.PatientRepository;
import com.sept.telemedicine.service.PatientService;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

//this class is used to test the backend functionality
@SpringBootTest
public class PatientControllerTests {

    @Autowired
    private PatientService patientService;

    @Test
    /*
     * Test for correct patient registration with correct details.
     */

    public void correctPatientRegistration() {
        Patient patient = new Patient("randomtest", "yoyo", "yoyo", "first", "last", "email@gmail.com");
        patientService.savePatient(patient);
        Assertions.assertNotNull(patientService.savePatient(patient));
    }

    /*
     * Testing username is taken method, this method takes a username and checks it
     * in the database (naming convention is wrong should be checkIfUsernameisTaken)
     * Should throw true as the username is in the database
     */

    @Test
    public void usernameExistsRegistration() {
        Patient patient = new Patient("asd", "yoyo", "yoyo", "first", "last", "email@gmail.com"); // username "asd"
                                                                                                  // exists in
                                                                                                  // database

        Assertions.assertTrue(patientService.checkIfUsernameIsFree(patient));
    }
    /*
     * Testing login method, gets the hashed password by username in database checks
     * if the encrypted password matches the hashed password in the database
     */

    @Test
    public void correctLogin() {
        Assertions.assertTrue(patientService.checkLoginCredentials("testing", "testing"));

    }

    /*
     * Testing get patient method, we have an already registed patient but we are
     * re-entering it's details. The method will get patient by it's username, so we
     * can access the Id and match it with the expected Id
     */
    @Test
    public void testGetPatient() {
        Patient patient = new Patient("testing", "testing", "testing", "first", "last", "test@gmail.com");
        patient.setId(14);
        Assertions.assertEquals(14, patientService.getPatientByUsername("testing").getId());
    }

    /*
     * Testing get patient method, here we are trying to get patient by username
     * that doesn't exist, as there is no patient it will throw a compile error
     */
    @Test
    public void testGetNotExistingPatient() throws RuntimeException {
        Assertions.assertThrows(RuntimeException.class, () -> {
            patientService.getPatientByUsername("idonotexist");
        });

    }

    /*
     * Testing update patient's information
     */
    @Test
    public void testUpdatePatient() {
        PatientDto patientInformation = new PatientDto(14, "male", 90.0, 90.0, "0123456789", "Teacher");
        patientService.updatePatient(patientInformation.getGender(), patientInformation.getWeight(),
                patientInformation.getHeight(), patientInformation.getContactNo(), patientInformation.getContactName(),
                patientInformation.getId());
        Assertions.assertEquals("male", patientService.findById(14).getGender());
        Assertions.assertEquals(90.0, patientService.findById(14).getWeight());
        Assertions.assertEquals(90.0, patientService.findById(14).getHeight());
        Assertions.assertEquals("0123456789", patientService.findById(14).getContactNo());
        Assertions.assertEquals("Teacher", patientService.findById(14).getContactName());

    }

    /*
     * Testing update of a patient that doesn't exist. The method require a
     * patient's ID and if the ID doesn't exist then the patient cannot be updated
     */

    @Test
    public void testUpdateNotExistingPatient() throws NullPointerException {
        PatientDto patientInformation = new PatientDto(99, "male", 90.0, 90.0, "0123456789", "Teacher");
        patientService.updatePatient(patientInformation.getGender(), patientInformation.getWeight(),
                patientInformation.getHeight(), patientInformation.getContactNo(), patientInformation.getContactName(),
                patientInformation.getId());

        Assertions.assertThrows(NullPointerException.class, () -> {
            patientService.findById(99).getGender();
        });
    }

    /*
     * Testing create health information row in database of table "patient_health".
     * Takes an ID and creates the row with default patient health information.
     */
    @Test
    public void testCreateHealthInformation() {
        Assertions.assertFalse(patientService.createPatientHealthInfo(1000).equals(null));

    }

    /*
     * Testing the update health information of patient method. The constructor was
     * somehow arranged wrong but should work allocate parameters correctly except
     * this one. First the patient is updated and then we retrieve the database
     * information and match it with the informatino we made.
     */
    @Test
    public void testUpdateHealthInformation() {
        PatientHealthInformation phi = new PatientHealthInformation(14, "mouth-cancer", "type 3", "positive",
                "positive", "negative", "weak bones", "lemsip", "drink in the morning", "brain surgery");
        patientService.updateHealthInfo(phi);
        Assertions.assertEquals(phi.getCancer(), patientService.getHealthInfo(14).get().getCancer());
        Assertions.assertEquals(phi.getDiabetes(), patientService.getHealthInfo(14).get().getDiabetes());
        Assertions.assertEquals(phi.getHeartDisease(), patientService.getHealthInfo(14).get().getHeartDisease());
        Assertions.assertEquals(phi.getKidneyDisease(), patientService.getHealthInfo(14).get().getKidneyDisease());
        Assertions.assertEquals(phi.getLiverDisease(), patientService.getHealthInfo(14).get().getLiverDisease());
        Assertions.assertEquals(phi.getMedicalProblems(), patientService.getHealthInfo(14).get().getMedicalProblems());
        Assertions.assertEquals(phi.getMedication(), patientService.getHealthInfo(14).get().getMedication());
        Assertions.assertEquals(phi.getMedicationDescription(),
                patientService.getHealthInfo(14).get().getMedicationDescription());
        Assertions.assertEquals(phi.getPastSurgeries(), patientService.getHealthInfo(14).get().getPastSurgeries());
    }

}
