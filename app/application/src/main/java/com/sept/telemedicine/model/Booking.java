package com.sept.telemedicine.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

@Table(name = "Booking")
public class Booking {
    String username;
    String location; //add a clinic database for locations
    String doctorName;
    Date date;

    public Booking(String username, String location, String doctorName, Date date){
        this.username = username;
        this.location = location;
        this.doctorName = doctorName;
        this.date = date;
    }

    public void setUsername(String username){
        this.username = username;
    }

    public void setLocation(String location){
        this.location = location;
    }

    public void setDoctorName(String doctorName){
        this.doctorName = doctorName;
    }

    public void setDate(Date date){
        this.date = date;
    }

    public String getUsername(){
        return username;
    }

    public String getLocation(){
        return location;
    }

    public String getDoctorName(){
        return doctorName;
    }

    public Date getDate(){
        return date;
    }


    
}
