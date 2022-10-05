package repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Example;
import org.springframework.data.jpa.repository.JpaRepository;

import model.Appointment;

public interface BookingRepository extends JpaRepository<Appointment, Long> {

    @Override
    List<Appointment> findAll();
    // TODO Auto-generated method stub

    @Override
    Optional<Appointment> findById(Long id);
    // TODO Auto-generated method stub

    List<Appointment> findByDoctorNameIgnoreCase(String doctorName);

}
