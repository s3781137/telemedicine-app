package com.sept.bookings.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sept.bookings.model.Booking;
import com.sept.bookings.repo.BookingRepo;

@Service
public class BookingService {
    
    @Autowired
    private BookingRepo repo;

    public Booking saveBooking(Booking b) {
        return repo.save(b);
    }

    public List<Booking> findAll() {
        return repo.findAll();
    }
}
