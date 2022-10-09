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
    


    public Booking saveBooking(Booking b) {
        repo.deleteAvailability(b.getDoctorName(),b.getDateTime());
        return repo.save(b);
    }

    public List<Booking> findAll() {
        return repo.findAll();
    }

    public void cancelBooking(int bookingId){
        Booking b=repo.getBookingById(bookingId);
        addAvailability(b.getDoctorUsername(),b.getDateTime());
        repo.deleteBooking(bookingId);
    }

    public List<Booking> viewPatientBookings(String patientUsername) {
        return repo.getBookingByPatientUsername(patientUsername);
    }

    public List<Booking> viewDoctorBookings(String DoctorUsername) {
        return repo.getBookingByDoctorUsername(DoctorUsername);
    }

    public List<DoctorAvailability> getAvailability(){
        return Availrepo.getAvailability();
    }
    public void addAvailability(String doctorUsername, String availability) {
        DoctorAvailability a=new DoctorAvailability(doctorUsername, availability);
        Availrepo.save(a);
    }
  
}
