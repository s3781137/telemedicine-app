package repository;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Appointment;

public interface BookingRepo extends JpaRepository<Appointment, Long> {

}
