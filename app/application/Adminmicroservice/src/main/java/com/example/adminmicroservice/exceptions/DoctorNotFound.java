package com.example.adminmicroservice.exceptions;

public class DoctorNotFound extends RuntimeException {
    public DoctorNotFound(String error) {
        super(error);
    }
}
