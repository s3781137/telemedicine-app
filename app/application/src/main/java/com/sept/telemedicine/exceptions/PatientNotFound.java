package com.sept.telemedicine.exceptions;

public class PatientNotFound extends RuntimeException {
    public PatientNotFound(String error) {
        super(error);
    }

}
