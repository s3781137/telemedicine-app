package com.sept.bookings.service;

@Service
public class BookingService {
    
    @Autowired
    private BookingRepo repo;

    public Booking saveBooking(Booking b) {
        return repo.save(b);
    }
}
