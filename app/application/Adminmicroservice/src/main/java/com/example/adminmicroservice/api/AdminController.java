package com.example.adminmicroservice.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;

import com.example.adminmicroservice.security.JwtTokenProvider;
import com.example.adminmicroservice.service.DoctorAccountService;
import com.example.adminmicroservice.service.MapValidationErrorService;

public class AdminController {

    @Autowired
    private DoctorAccountService dService;

    @Autowired
    private JwtTokenProvider tokenProvider;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private MapValidationErrorService mapValidationErrorService;

}
