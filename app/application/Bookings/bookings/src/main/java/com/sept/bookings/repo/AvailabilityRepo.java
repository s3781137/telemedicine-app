package com.sept.bookings.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.sept.bookings.model.DoctorAvailability;




@Repository
public interface AvailabilityRepo extends JpaRepository<DoctorAvailability, Integer> {


    //delete a doctor avalability from the database
    @Modifying
    @Query("Delete from DoctorAvailability ")
    void deleteAvailability(String doctorUsername, String availability);

    //get a doctors avalability from the database
    @Query("Select m from DoctorAvailability m where m.doctorUsername = ?1 and m.availability = ?2")
    DoctorAvailability getAvailabilityByUsername(String doctorUsername, String availability);

    //get all the avalabilities added from the database
    @Query("Select m FROM DoctorAvailability m")
    List<DoctorAvailability> getAvailability();
    
}