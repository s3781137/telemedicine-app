package com.sept.bookings.model;

import java.time.LocalDateTime;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "booking")
@Entity
public class Booking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    String usernameDoctor;

    String usernamePatient;
    // String location; //add a clinic database for locations

    Date date;

    private LocalDateTime startTime;

    private LocalDateTime endTime;

    public Booking(String usernameDoctor, String usernamePatient, Date date, LocalDateTime startTime,
            LocalDateTime endTime) {
        this.usernameDoctor = usernameDoctor;
        this.usernamePatient = usernamePatient;
        // this.location = location;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public int getID() {
        return id;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public void setUsernameDoctor(String usernameDoctor) {
        this.usernameDoctor = usernameDoctor;
    }

    public void setUsernamePatient(String usernamePatient) {
        this.usernamePatient = usernamePatient;
    }

    // public void setLocation(String location){
    // this.location = location;
    // }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getUsernameDoctor() {
        return usernameDoctor;
    }

    public String getUsernamePatient() {
        return usernamePatient;
    }

    // public String getLocation(){
    // return location;
    // }

    public Date getDate() {
        return date;
    }

}
