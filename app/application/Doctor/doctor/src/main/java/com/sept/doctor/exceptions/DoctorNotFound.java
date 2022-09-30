package com.sept.doctor.exceptions;

public class DoctorNotFound extends RuntimeException {
    public DoctorNotFound(String error) {
        super(error);
    }
}
