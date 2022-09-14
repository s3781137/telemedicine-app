package com.sept.telemedicine.dto;

import com.sept.telemedicine.model.Doctor;
import java.util.ArrayList;
import java.util.Iterator;

public class DoctorDto {
    private int id;
    private String gender;
    private double weight;
    private double height;
    private String contactNo;
    private String contactName;

    private ArrayList<Doctor> DoctorList = new ArrayList<>();

    public DoctorDto() {
    }

    public DoctorDto(int id, String gender, double weight, double height, String contactNo, String contactName) {
        this.id = id;
        this.gender = gender;
        this.weight = weight;
        this.height = height;
        this.contactNo = contactNo;
        this.contactName = contactName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    
    public boolean findByEmailAndPassword(String  DoctorId, String pwd){
        for (Doctor i: DoctorList ){
            if(i.getDoctorId()== DoctorId){
                if(i.getPassword() == pwd){
                    return true;
                }  
            }
        }
        return false;
    }

    public boolean createUser(Doctor p){
        for (Doctor i: DoctorList ){
            if(i.getDoctorId()== p.getDoctorId()){
                return false; //the Doctor is already present
            }
        }
        DoctorList.add(p);//add new Doctor
        return true; 
    }
}
