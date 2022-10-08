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


    
}
