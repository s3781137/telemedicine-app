package com.example.adminmicroservice.service;

import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.util.Pair;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.adminmicroservice.model.Admin;
import com.example.adminmicroservice.repository.AdminRepository;

@Service
public class AdminService {

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private AdminRepository repo;

    // save admin account into database
    public Admin saveAdmin(Admin admin) {
        admin.setPassword(bCryptPasswordEncoder.encode(admin.getPassword()));
        admin.setUsername(admin.getUsername());
        admin.setConfirmPassword(bCryptPasswordEncoder.encode(admin.getConfirmPassword()));
        return repo.save(admin);
    }

    // get admin account by username
    public Admin getAdminByUsername(String username) {
        Optional<Admin> admin = repo.findAdminByUsername(username);
        if (admin.isPresent()) {
            return admin.get();
        } else {
            throw new RuntimeException("There is no Admin against this username: " + username);
        }
    }

    // checks if username is taken in database
    public boolean checkIfUsernameIsFree(Admin admin) {
        Optional<Admin> existingAdmin = repo.findAdminByUsername(admin.getUsername());
        return existingAdmin.isPresent();
    }

    // delete admin account
    public void deleteAdmin(String username) {
        int id = repo.findIdByUsername(username);
        repo.deleteById(id);
    }

    // finds id of account by username
    public Integer findIdByUsername(String username) {
        return repo.findIdByUsername(username);
    }

    // checks login credentials
    public boolean checkLoginCredentials(String username, String password) {
        Optional<Admin> existingAdmin = repo.findAdminByUsername(username);
        if (existingAdmin.isPresent()) {
            return bCryptPasswordEncoder.matches(password, repo.findPasswordByUsername(username));

        }
        return false;
    }

    // matches decrypted password
    public boolean doPasswordsMatch(String hashedPassword, String plainTextPassword) {
        return bCryptPasswordEncoder.matches(plainTextPassword, hashedPassword);
    }

    // finds admin and gets the password stored in database
    public boolean comparePassword(String username, String plainTextPassword) {
        Optional<Admin> admin = repo.findAdminByUsername(username);
        return (admin.isPresent() && doPasswordsMatch(admin.get().getPassword(), plainTextPassword));
    }

    // jwt login
    public Pair<Optional<String>, Optional<Admin>> login(String username, String plainTextPassword) {
        Optional<Admin> AdminOptional = repo.findAdminByUsername(username);

        Optional<String> token = Optional.empty();
        if (comparePassword(username, plainTextPassword)) {
            token = Optional.of(UUID.randomUUID().toString());
            Admin admin = AdminOptional.get();
            admin.setToken(token.get());
        }
        return Pair.of(token, AdminOptional);
    }

    public void setAdminToken(String token, String username) {
        repo.setToken(token, username);

    }
}
