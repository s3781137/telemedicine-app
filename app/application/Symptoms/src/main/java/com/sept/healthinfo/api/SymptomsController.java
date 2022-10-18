package com.sept.healthinfo.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sept.healthinfo.exceptions.PatientNotFound;
import com.sept.healthinfo.model.Symptoms;
import com.sept.healthinfo.service.SymptomsService;

@RestController
@RequestMapping("/symptoms")
public class SymptomsController {

    @Autowired
    private SymptomsService service;

    @GetMapping("/getSymptoms/{username}")
    public ResponseEntity<?> getSymptoms(@PathVariable(name = "username") String username) {

        if (service.getSymptomsByUsername(username) == null) {

            service.makeDefaultSymptoms(username);
        }
        Symptoms symptoms = service.getSymptomsByUsername(username);
        return new ResponseEntity<>(symptoms, HttpStatus.OK);

    }

    // @PostMapping("/makeSymptoms/{usernamne}")
    // public ResponseEntity<?> makeSymptoms(@PathVariable(name = "username") String
    // username) {
    // try {
    // service.makeDefaultSymptoms(username);
    // return new ResponseEntity<>("Made default symptoms for " + username,
    // HttpStatus.OK);
    // } catch (Exception e) {
    // return new ResponseEntity<>("error", HttpStatus.NOT_ACCEPTABLE);
    // }
    // }

    @PutMapping("updateSymptoms/{username}")
    public ResponseEntity<?> updateSymptoms(@PathVariable(name = "username") String username,
            @RequestBody Symptoms newSymptoms) {
        Symptoms oldSymptoms = service.findSymptomsByUsername(username);
        if (!(oldSymptoms == null)) {
            oldSymptoms.setBodyTemperature(newSymptoms.getBodyTemperature());
            oldSymptoms.setCough(newSymptoms.getCough());
            oldSymptoms.setPainScale(newSymptoms.getPainScale());
            oldSymptoms.setRunnyNose(newSymptoms.isRunnyNose());
            service.updateSymptoms(oldSymptoms);
            return new ResponseEntity<>(oldSymptoms, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("There is Symptoms with this username", HttpStatus.OK);
        }

    }
}
