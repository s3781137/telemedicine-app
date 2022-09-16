package com.sept.telemedicine.dto;

//object to store patient details in patient
public class PatientDto {
    private int id;
    private String status;
    private String gender;
    private double weight;
    private double height;
    private String contactNo;
    private String contactName;

    public PatientDto() {
    }

    public PatientDto(int id, String status, String gender, double weight, double height, String contactNo,
            String contactName) {
        this.status = status;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
