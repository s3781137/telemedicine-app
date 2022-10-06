package com.sept.bookings.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.sept.bookings.model.Booking;
import com.sept.bookings.repository.BookingRepo;



@Service
public class BookingService {
    private BookingRepo brepo;

    public void saveBooking(Booking booking) {
       
        brepo.save(booking);

    }

    public ArrayList<Booking> getBookingList(String usernamePatient) {
        return brepo.getPatientBookingDetails(usernamePatient);
    }
    
}
