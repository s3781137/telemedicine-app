package com.sept.doctor;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.sept.healthinfo.SymptomsApplication;
import com.sept.healthinfo.model.Symptoms;
import com.sept.healthinfo.service.SymptomsService;

@ContextConfiguration(classes = SymptomsApplication.class)
@SpringBootTest
public class SymptomsControllerTests {

    @Autowired
    private SymptomsService service;

    // test get symptoms
    @Test
    public void getSymptomsTest() {
        service.makeDefaultSymptoms("junittest");
        Assertions.assertNotNull(service.getSymptomsByUsername("junittest"));
    }

    // test update symptoms with old set of symptoms and new set of symptoms
    @Test
    public void updateSymptomsTest() {
        Symptoms newSymptoms = new Symptoms(5, 5, "a lot", true, "junittest");
        Symptoms oldSymptoms = service.getSymptomsByUsername("junittest");
        oldSymptoms.setBodyTemperature(newSymptoms.getBodyTemperature());
        oldSymptoms.setCough(newSymptoms.getCough());
        oldSymptoms.setPainScale(newSymptoms.getPainScale());
        oldSymptoms.setRunnyNose(newSymptoms.isRunnyNose());
        service.updateSymptoms(oldSymptoms);
        Assertions.assertEquals(service.getSymptomsByUsername("junittest").getBodyTemperature(),
                newSymptoms.getBodyTemperature());
        Assertions.assertEquals(service.getSymptomsByUsername("junittest").getCough(), newSymptoms.getCough());
        Assertions.assertEquals(service.getSymptomsByUsername("junittest").getPainScale(), newSymptoms.getPainScale());
        Assertions.assertEquals(service.getSymptomsByUsername("junittest").isRunnyNose(), newSymptoms.isRunnyNose());
    }
}
