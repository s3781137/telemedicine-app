package com.sept.telemedicine.exceptions;

//this is an exception class which is invoked when we throw custom exceptions

public class PatientNotFound extends RuntimeException {
    public PatientNotFound(String error) {
        super(error);
    }

}
