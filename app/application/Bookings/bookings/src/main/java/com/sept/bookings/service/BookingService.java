package com.sept.bookings.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sept.bookings.model.Booking;
import com.sept.bookings.model.DoctorAvailability;
import com.sept.bookings.repo.AvailabilityRepo;
import com.sept.bookings.repo.BookingRepo;


@Service
public class BookingService {
    
    @Autowired
    private BookingRepo repo;
    @Autowired
    private AvailabilityRepo Availrepo;
    


    ////saves a booking to the database
    public Booking saveBooking(Booking b) {
        DoctorAvailability d = Availrepo.getAvailabilityByUsername(b.getDoctorUsername(), b.getDateTime());
        Availrepo.delete(d);
        return repo.save(b);
    }

    //lists all the bookings
    public List<Booking> findAll() {
        return repo.findAll();
    }

    //cancels a booking and adds the doctor's avalability back
    public boolean cancelBooking(int bookingId){
        Booking b=repo.getBookingById(bookingId);
        addAvailability(b.getDoctorUsername(),b.getDateTime());
        //repo.deleteBooking(bookingId);
        repo.delete(b);
        return true;
    }

    //lists all the bookings for a patient
    public List<Booking> viewPatientBookings(String patientUsername) {
        return repo.getBookingByPatientUsername(patientUsername);
    }

    //lists all the bookings for a doctor
    public List<Booking> viewDoctorBookings(String DoctorUsername) {
        return repo.getBookingByDoctorUsername(DoctorUsername);
    }

    //lists all the avalabilities of all the doctors
    public List<DoctorAvailability> getAvailability(){
        return Availrepo.getAvailability();
    }

    //adds a doctors avalability to the database
    public DoctorAvailability addAvailability(String doctorUsername, String availability) {
        DoctorAvailability a=new DoctorAvailability(doctorUsername, availability);
        return Availrepo.save(a);
        
    }
  
}
