package com.example.medicine.exception;

public class PrescriptionNotFound extends RuntimeException{
    

    //this is an exception class which is invoked when we throw custom exceptions
 
    public PrescriptionNotFound(String error) {
            super(error);
    }
    

     
}
