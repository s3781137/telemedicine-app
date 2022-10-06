package com.example.adminmicroservice.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.adminmicroservice.dto.Doctor;
import com.example.adminmicroservice.repository.AdminRepository;
import com.example.adminmicroservice.repository.DoctorRepository;

@Service
public class DoctorAccountService {

    @Autowired
    private DoctorRepository repo;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    public Doctor getDoctorById(Integer id) {
        return repo.findById(id).get();
    }

    public List<Doctor> findAll() {
        return repo.findAll();
    }

    public Doctor saveDoctor(Doctor doctor) {
        doctor.setPassword(bCryptPasswordEncoder.encode(doctor.getPassword()));
        doctor.setUsername(doctor.getUsername());
        return repo.save(doctor);
    }

    public Doctor getDoctorByUsername(String username) {
        Optional<Doctor> doctor = repo.findDoctorByUsername(username);
        if (doctor.isPresent()) {
            return doctor.get();
        } else {
            throw new RuntimeException("There is no doctor against this username: " + username);
        }
    }

    public boolean checkIfUsernameIsFree(Doctor doctor) {
        Optional<Doctor> existingDoctor = repo.findDoctorByUsername(doctor.getUsername());
        return existingDoctor.isPresent();
    }

    public void deleteDoctor(String username) {
        int id = repo.findIdByUsername(username);
        repo.deleteById(id);
    }

    public Integer findIdByUsername(String username) {
        return repo.findIdByUsername(username);
    }

    public boolean checkLoginCredentials(String username, String password) {
        Optional<Doctor> existingDoctor = repo.findDoctorByUsername(username);
        if (existingDoctor.isPresent()) {
            return bCryptPasswordEncoder.matches(password, repo.findPasswordByUsername(username));

        }
        return false;
    }

    public boolean doPasswordsMatch(String hashedPassword, String plainTextPassword) {
        return bCryptPasswordEncoder.matches(plainTextPassword, hashedPassword);
    }

    public boolean comparePassword(String username, String plainTextPassword) {
        Optional<Doctor> doctor = repo.findDoctorByUsername(username);
        return (doctor.isPresent() && doPasswordsMatch(doctor.get().getPassword(), plainTextPassword));
    }

}
