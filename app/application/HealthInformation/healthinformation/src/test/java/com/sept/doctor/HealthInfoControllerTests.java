// package com.sept.doctor;

// import org.junit.jupiter.api.Assertions;
// import org.junit.jupiter.api.Test;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.boot.test.context.SpringBootTest;
// import org.springframework.test.context.ContextConfiguration;

// import com.sept.healthinfo.HealthInfoApplication;
// import com.sept.healthinfo.model.HealthInformation;
// import com.sept.healthinfo.service.HealthInfoService;

// @ContextConfiguration(classes = HealthInfoApplication.class)
// @SpringBootTest
// public class HealthInfoControllerTests {

//     @Autowired
//     private HealthInfoService service;

//     // test to make health information for a patient
//     @Test
//     public void makeHealthInfoTest() {
//         HealthInformation info = new HealthInformation(10000, "none", "none", "none", "none", "none", "none", "none",
//                 "none", "none");
//         service.updateHealthInfo(info);
//         Assertions.assertNotNull(service.getHealthInfo(1000));
//     }

//     // test update health info
//     @Test
//     public void updateHealthInfoTest() {
//         HealthInformation oldInfo = new HealthInformation(100001, "many", "many", "many", "many", "many", "many",
//                 "many",
//                 "many", "many");
//         service.updateHealthInfo(oldInfo);
//         HealthInformation info = new HealthInformation(oldInfo.getId(), "none", "none", "none", "none", "none", "none",
//                 "none",
//                 "none", "none");
//         service.updateHealthInfo(info);
//         Assertions.assertEquals(service.getHealthInfo(100001).get().getCancer(), info.getCancer());
//         Assertions.assertEquals(service.getHealthInfo(100001).get().getDiabetes(), info.getDiabetes());
//         Assertions.assertEquals(service.getHealthInfo(100001).get().getHeartDisease(), info.getKidneyDisease());
//     }
// }
