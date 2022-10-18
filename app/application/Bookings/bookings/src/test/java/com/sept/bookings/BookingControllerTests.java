package com.sept.bookings;

import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;

import com.sept.bookings.api.*;
import com.sept.bookings.config.*;
import com.sept.bookings.model.*;
import com.sept.bookings.service.*;
import com.sept.bookings.repo.*;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

@SpringBootTest
public class BookingControllerTests {

    @Autowired
    BookingService service;

    @Test
    public void testAddAvailibility() throws RuntimeException{
        Assertions.assertNotNull(service.addAvailability("Dr Jin", "26/08/2000 16:30-18:30"));

    }

    @Test
    public void testGetAvailibility(){
        Assertions.assertNotNull(service.getAvailability());
    }

    @Test
    public void testAddBooking() throws RuntimeException{
        service.addAvailability("Dr RM", "27/09/2001 17:30-18:30");
        Booking b = new Booking("Dr RM", "Aishwarya", "Namjoon", "aishwarya", "27/09/2001 17:30-18:30");
        Assertions.assertNotNull(b);
    }

    @Test
    public void testListBookings() throws RuntimeException{
        // service.addAvailability("Dr Jeon", "27/09/2001 17:30-18:30");
        // Booking b = new Booking("Dr RM", "Jungkook", "Namjoon", "aishwarya", "27/09/2001 17:30-18:30");
        Assertions.assertNotNull(service.findAll());
    }

    @Test
    public void testCancelBooking() throws RuntimeException{
        service.addAvailability("Dr Bangchan", "27/09/2001 17:30-18:30");
        Booking b = new Booking("Dr Bangchan", "uniquename", "Namjoon", "aishwarya", "27/09/2001 17:30-18:30");
        Booking b1 = service.saveBooking(b);
        
        Assertions.assertTrue(service.cancelBooking(b1.getId()));

    }

    @Test
    public void testViewPatientBookings() throws RuntimeException{
        service.addAvailability("Dr Felix", "27/09/2001 11:30-17:30");
        Booking b = new Booking("Dr Felix", "Aish", "Namjoon", "aishwarya", "27/09/2001 11:30-17:30");
        Booking b1 = service.saveBooking(b);
        Assertions.assertNotNull(service.viewPatientBookings("Aish"));
    }

    @Test
    public void testViewDoctorBookings() throws RuntimeException{
        service.addAvailability("Dr ChangBin", "29/09/2001 11:30-17:30");
        Booking b = new Booking("Dr ChangBin", "V", "Namjoon", "aishwarya", "29/09/2001 11:30-17:30");
        Booking b1 = service.saveBooking(b);
        Assertions.assertNotNull(service.viewDoctorBookings("Dr ChangBin"));
    }


}
