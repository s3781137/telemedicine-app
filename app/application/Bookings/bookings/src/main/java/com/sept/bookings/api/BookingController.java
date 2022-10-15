package com.sept.bookings.api;

import java.util.HashMap;
import java.util.List;
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

import com.sept.bookings.exceptions.AvailablityNotFoundException;
import com.sept.bookings.exceptions.BookingNotFoundException;
import com.sept.bookings.model.Booking;
import com.sept.bookings.model.DoctorAvailability;
import com.sept.bookings.service.BookingService;

@RestController
@RequestMapping("/booking")
public class BookingController {
    
    @Autowired
    private BookingService service;

    @PostMapping("/addBooking")
    public ResponseEntity<?> addBooking(@RequestBody Booking b) {
         try {
        //     service.updateHealthInfo(b);
            service.saveBooking(b);
            Map<String, Object> response = new HashMap<>();
            response.put("id", b.getId());
            response.put("message", "booking registered");
            return new ResponseEntity<>(response, HttpStatus.OK);

         } catch (Exception e) {
            throw e;
         }

    }
    @GetMapping("/list")
        
        public List<Booking> getBookings() {
            try{
            return service.findAll();
            }catch(Exception e){
            throw new BookingNotFoundException("Booking not found");
            }
    }

    @GetMapping("/cancelBooking")
    public ResponseEntity<?> cancelBooking(@RequestParam int bookingId){
        try{
        service.cancelBooking(bookingId);
        Map<String, Object> response = new HashMap<>();
            response.put("id",bookingId);
            response.put("message", "booking cancelled");
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch(Exception e){
            throw new BookingNotFoundException("Booking not found");
            }

    }
    
    @GetMapping("/viewPatientBookings")
    public List<Booking> viewPatientBookings(@RequestParam String patientUsername ){
        try{
        List<Booking> bookings=service.viewPatientBookings(patientUsername);
        
        return bookings;
        } catch(Exception e){
            throw new BookingNotFoundException("Booking not found");
            }
    }

    @GetMapping("/viewDoctorBookings")
    public List<Booking> viewDoctorBookings(@RequestParam String doctorUsername ){
        try{
        List<Booking> bookings=service.viewDoctorBookings(doctorUsername);
        
        return bookings;
        } catch(Exception e){
            throw new BookingNotFoundException("Booking not found");
            }
    }

    @PostMapping("/addAvailability")
    public ResponseEntity<?> addAvailability(@RequestParam String doctorUsername, @RequestParam String availability){
        try{
        service.addAvailability(doctorUsername,availability);
        Map<String, Object> response = new HashMap<>();
            response.put("message", "added availability");
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch(Exception e){
            throw new AvailablityNotFoundException("Availability not found");
            }
    }

    @GetMapping("/getAvailability")
    public List<DoctorAvailability> getAvailability() {
        try{
        return service.getAvailability();
    } catch(Exception e){
        throw new AvailablityNotFoundException("Availability not found");
        }
}

}
