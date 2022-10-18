package com.sept.bookings.exceptions;

public class AvailablityNotFoundException extends RuntimeException{
    public AvailablityNotFoundException(String error) {
        super(error);
    }
}
