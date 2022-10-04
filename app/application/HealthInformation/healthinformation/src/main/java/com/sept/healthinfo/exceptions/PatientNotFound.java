package com.sept.healthinfo.exceptions;

public class PatientNotFound extends RuntimeException {
    public PatientNotFound(String error) {
        super(error);
    }
}
