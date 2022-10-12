package com.example.medicine.model;


import javax.persistence.*;

@Entity
@Table(name = "Prescription")
public class Prescription {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    String doctorUsername;
    String patientUsername;
    String medicine;

    public Prescription(){

    }

    public Prescription(String dname,String pname,String med){
        this.doctorUsername=dname;
        this.patientUsername=pname;
        this.medicine=med;
        
    }

    public String getdoctorUsername(){
        return doctorUsername;
    }

    public String getpatientUsername(){
        return patientUsername;
    }

    public String getMedicine(){
        return medicine;
    }

    public int getId(){
        return id;
    }
    
}

