package com.sept.bookings.repository;

// import com.sept.telemedicine.model.Patient;
// import com.sept.telemedicine.model.PatientHealthInformation;
import org.springframework.data.jpa.repository.JpaRepository;
// import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
// import org.springframework.transaction.annotation.Transactional;

import com.sept.bookings.model.Booking;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.persistence.Table;

@Table(name = "booking")
@Repository
public interface BookingRepo extends JpaRepository<Booking, Integer> {

    @Query("SELECT * FROM booking WHERE usernamePatient = ?1")
    ArrayList<Booking> getPatientBookingDetails(@Param("usernamePatient") String usernamePatient);

    // @Query("select b from BookingEntity b where (" +
    //         "not (:startDateTime < b.startDateTime and :endDateTime < b.startDateTime)" +
    //         "and not (:startDateTime > b.endDateTime and :endDateTime > b.endDateTime)" +
    //         ")")
    // List<Booking> findAllInRange(LocalDateTime startDateTime, LocalDateTime endDateTime);

    // @Query("select b from BookingEntity b where (" +
    // "((:workerUsername =  b.workerUsername) or (:customerUsername = b.customerUsername))" +
    // "and not (:startDateTime <= b.startDateTime and :endDateTime <= b.startDateTime)" +
    // "and not (:startDateTime >= b.endDateTime and :endDateTime >= b.endDateTime)" +
    // ")")
    // List<Booking> findConflictingHours(String workerUsername, String customerUsername, LocalDateTime startDateTime, LocalDateTime endDateTime);
}
