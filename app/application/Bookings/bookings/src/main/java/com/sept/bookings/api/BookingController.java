package com.sept.bookings.api;

@RestController
@RequestMapping("/healthinfo")
public class BookingController {
    
    @Autowired
    private BookingService service;

    @PostMapping("/addBooking")
    public ResponseEntity<?> addBooking(@RequestBody Booking b) {
        try {
            service.updateHealthInfo(healthInfo);
            Map<String, Object> response = new HashMap<>();
            response.put("id", healthInfo.getId());
            response.put("message", "health information registered");
            return new ResponseEntity<>(response, HttpStatus.OK);

        } catch (Exception e) {
            throw new PatientNotFound("Patient database error");
        }
    }
}
