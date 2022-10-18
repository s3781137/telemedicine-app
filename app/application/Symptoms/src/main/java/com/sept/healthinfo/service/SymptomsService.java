package com.sept.healthinfo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sept.healthinfo.model.Symptoms;
import com.sept.healthinfo.repo.SymptomsRepository;

@Service
public class SymptomsService {

    @Autowired
    private SymptomsRepository repo;

    // use repository find symptoms by username

    public Symptoms getSymptomsByUsername(String username) {
        return repo.findSymptomsByUsername(username);
    }

    // saves default symptoms under the patient's username

    public void makeDefaultSymptoms(String username) {
        Symptoms defaultSymptoms = new Symptoms(0, 0, "no", false, username);
        repo.save(defaultSymptoms);
    }

    // saves symptoms passing through symptom object

    public void updateSymptoms(Symptoms symptoms) {
        repo.save(symptoms);
    }

}
