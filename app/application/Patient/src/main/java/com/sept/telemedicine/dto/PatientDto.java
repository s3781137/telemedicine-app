package com.sept.telemedicine.dto;

//this class is used to store the patient information so that it can be accessed
//by other classes in case the information needs to be updated. 

public class PatientDto {
    private int id;
    private String gender;
    private double weight;
    private double height;
    private String contactNo;
    private String contactName;

    public PatientDto() {
    }

    public PatientDto(int id, String gender, double weight, double height, String contactNo, String contactName) {
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
}
