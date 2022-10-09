package com.sept.bookings.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.sept.bookings.model.DoctorAvailability;



@Repository
public interface AvailabilityRepo extends JpaRepository<DoctorAvailability, Integer> {


    @Query("Delete from DoctorAvailability where doctorUsername=?1 and availability=?2")
    void deleteAvailability(String doctorName, String dateTime);
    
}