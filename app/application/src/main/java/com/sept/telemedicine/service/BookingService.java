package com.sept.telemedicine.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.sept.telemedicine.model.Booking;
import com.sept.telemedicine.repository.BookingRepo;

@Service
public class BookingService {
    private BookingRepo brepo;

    public void saveBooking(Booking booking) {
       
        brepo.save(booking);

    }

    // public ArrayList<Booking> getBookingList(String username) {
    //     return brepo.getPatientBookingDetails(username);
    // }
    
}
