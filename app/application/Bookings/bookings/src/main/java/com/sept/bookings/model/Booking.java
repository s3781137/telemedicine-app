package com.sept.bookings.model;

import javax.persistence.*;

@Entity
@Table(name = "book")
public class Booking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String doctorUsername;
    private String patientUsername;
    private String doctorName;
    private String patientName;
    private String bDate;
    private String startTime;
    private String endTime;

    public Booking(){

    }

    public Booking(String doctorUsername, String patientUsername, 
    String doctorName, String patientName, String bDate, 
    String startTime, String endTime){
        this.doctorUsername = doctorUsername;
        this.patientUsername = patientUsername;
        this.doctorName = doctorName;
        this.patientName = patientName;
        this.bDate = bDate;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public int getId(){
        return id;
    }

    public String getDoctorUsername(){
        return doctorUsername;
    }

    public String getPatientUsername(){
        return patientUsername;
    }

    public String getDoctorName(){
        return doctorName;
    }

    public String getPatientName(){
        return patientName;
    }

    public String getbDate(){
        return bDate;
    }

    public String getStartTime(){
        return startTime;
    }

    public String getEndTime(){
        return endTime;
    }

}
