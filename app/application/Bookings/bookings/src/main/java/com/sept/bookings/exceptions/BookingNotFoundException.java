package com.sept.bookings.exceptions;

public class BookingNotFoundException extends RuntimeException {

    public BookingNotFoundException(String error) {
        super(error);
    }
    
}
