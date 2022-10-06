package com.example.adminmicroservice.exceptions;

public class AdminNotFound extends RuntimeException {
    public AdminNotFound(String error) {
        super(error);
    }

}
