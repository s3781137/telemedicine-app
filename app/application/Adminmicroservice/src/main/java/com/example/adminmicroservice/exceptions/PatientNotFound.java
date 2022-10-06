package com.example.adminmicroservice.exceptions;

public class PatientNotFound extends RuntimeException {
    public PatientNotFound(String error) {
        super(error);
    }

}
