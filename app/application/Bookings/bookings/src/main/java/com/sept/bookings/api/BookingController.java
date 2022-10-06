package com.sept.bookings.api;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sept.bookings.model.Booking;
import com.sept.bookings.service.BookingService;



@RestController
@RequestMapping("/booking")
public class BookingController {

    @Autowired
    private BookingService service;

    @GetMapping("/bookingList")
    public ArrayList<Booking> getBookings(String usernamePatient) {
        return service.getBookingList(usernamePatient);
    }

    @PostMapping("/addBooking")
    public ResponseEntity<?> addBooking(@RequestParam String usernamePatient, @RequestParam String usernameDoctor, @RequestParam Date date, @RequestParam LocalDateTime startTime, LocalDateTime endTime ) {
        Booking booking = new Booking(usernamePatient, usernameDoctor, date, startTime, endTime);
       
        Map<String, Object> response = new HashMap<>();
        response.put("status", HttpStatus.OK);

        service.saveBooking(booking);
        return new ResponseEntity<>(response, HttpStatus.OK);

    }

    
}
