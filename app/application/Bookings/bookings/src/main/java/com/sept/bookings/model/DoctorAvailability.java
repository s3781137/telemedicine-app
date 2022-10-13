package com.sept.bookings.model;
import javax.persistence.*;

@Entity
@Table(name = "Availability")
public class DoctorAvailability {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    String doctorUsername;
    String availability;

    public DoctorAvailability(){

    }
    public DoctorAvailability(String username,String avail){
        this.doctorUsername=username;
        this.availability=avail;
    }

    public int getId(){
        return id;
    }

    public String getDoctorUsername(){
        return doctorUsername;
    }

    public String getAvailability(){
        return availability;
    }
}
