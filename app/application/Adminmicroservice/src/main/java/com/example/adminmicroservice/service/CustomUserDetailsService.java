package com.example.adminmicroservice.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.adminmicroservice.dto.Doctor;
import com.example.adminmicroservice.model.Admin;
import com.example.adminmicroservice.repository.AdminRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private AdminRepository adminRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserDetails admin = adminRepository.findByUsername(username);
        if (admin == null)
            new UsernameNotFoundException("User not found");
        return admin;

    }

    @Transactional
    public Admin loadUserById(Long id) {
        Admin user = adminRepository.getById(id);
        if (user == null)
            new UsernameNotFoundException("User not found");
        return user;

    }
}
