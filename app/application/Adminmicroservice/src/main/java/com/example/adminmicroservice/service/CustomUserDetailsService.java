package com.example.adminmicroservice.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.adminmicroservice.dto.Doctor;
import com.example.adminmicroservice.repository.DoctorRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private DoctorRepository doctorRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserDetails doctor = doctorRepository.findByUsername(username);
        if (doctor == null)
            new UsernameNotFoundException("User not found");
        return doctor;

    }

    @Transactional
    public Doctor loadUserById(Long id) {
        Doctor user = doctorRepository.getById(id);
        if (user == null)
            new UsernameNotFoundException("User not found");
        return user;

    }
}
