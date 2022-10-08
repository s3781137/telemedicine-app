package com.sept.bookings.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.sept.bookings.model.Booking;
import com.sept.bookings.repository.BookingRepo;

@Service
public class BookingService {
    private BookingRepo brepo;

    public void saveBooking(Booking booking) {

        brepo.save(booking);

    }

    // public List<Booking> getBookingList(String usernamePatient) {
    //     return brepo.findByUsernamePatient(usernamePatient);
    // }

}
