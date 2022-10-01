package com.sept.telemedicine.api;

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

import com.sept.telemedicine.model.Booking;
import com.sept.telemedicine.service.BookingService;

@RestController
@RequestMapping("/patient/booking")
public class BookingController {

    @Autowired
    private BookingService service;

    // @GetMapping("/bookingList")
    // public ArrayList<Booking> getBookings(String username) {
    //     return service.getBookingList(username);
    // }

    @PostMapping("/addBooking")
    public ResponseEntity<?> addBooking(@RequestParam String username, @RequestParam String location, @RequestParam String doctorName, @RequestParam Date date) {
        Booking booking = new Booking(username, location, doctorName, date);
       
        Map<String, Object> response = new HashMap<>();
        response.put("status", HttpStatus.OK);

        service.saveBooking(booking);
        return new ResponseEntity<>(response, HttpStatus.OK);

    }

    
}
