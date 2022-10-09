package com.sept.bookings.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.sept.bookings.model.Booking;



@Repository
public interface BookingRepo extends JpaRepository<Booking, Integer> {

    @Query("Select m FROM Booking m")
    List<Booking> findAll();

    @Query("Delete from Booking where id=?1")
    void deleteBooking(int id);

    @Query("Select b from Booking b where patientUsername=?1")
    List<Booking> getBookingByPatientUsername(String patientUsername);

    @Query("Delete from DoctorAvailability where doctorUsername=?1 and availability=?2")
    void deleteAvailability(String doctorName, String dateTime);

    @Query("Select b FROM Booking b where id=?1")
    Booking getBookingById(int id);

    @Query("Select b from Booking b where doctorUsername=?1")
    List<Booking> getBookingByDoctorUsername(String doctorUsername);
    
}
