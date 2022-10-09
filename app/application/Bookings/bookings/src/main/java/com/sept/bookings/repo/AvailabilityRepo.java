package com.sept.bookings.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.sept.bookings.model.DoctorAvailability;




@Repository
public interface AvailabilityRepo extends JpaRepository<DoctorAvailability, Integer> {


    
    @Modifying
    @Query("Delete from DoctorAvailability ")
    void deleteAvailability(String doctorUsername, String availability);

    @Query("Select m from DoctorAvailability m where m.doctorUsername = ?1 and m.availability = ?2")
    DoctorAvailability getAvailabilityByUsername(String doctorUsername, String availability);

    @Query("Select m FROM DoctorAvailability m")
    List<DoctorAvailability> getAvailability();
    
}