package com.example.adminmicroservice.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "patient")
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "username")
    private String username;
    private String password;
    @Column(name = "confirm_password")
    private String confirmPassword;
    private String firstName;
    private String lastName;
    private String status;
    private String email;
    private String gender;
    private double weight;
    private double height;
    private String contactNo;
    private String contactName;

    public Patient() {

    }

    // the mandotary fields for a patient are username, password, confirm pass,
    // firstname, last name and email for a patient to register the account.
    // the other parameters are passed as null since they are not required for
    // registration
    // however they can still be modified when a patient needs to update their
    // information.
    public Patient(String username, String password, String confirmPassword, String firstName, String lastName,
            String email) {
        this.id = 0;
        this.username = username;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.confirmPassword = confirmPassword;
        this.weight = 0;
        this.height = 0;
        this.status = null;
        this.gender = null;
        this.contactNo = null;
        this.contactName = null;
    }

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getStatus() {
        return status;
    }

    public String getEmail() {
        return email;
    }

    public String getGender() {
        return gender;
    }

    public double getWeight() {
        return weight;
    }

    public double getHeight() {
        return height;
    }

    public String getContactNo() {
        return contactNo;
    }

    public String getContactName() {
        return contactName;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    @Override
    public String toString() {
        return "Patient{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", confirmPassword='" + confirmPassword + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", status='" + status + '\'' +
                ", email='" + email + '\'' +
                ", gender='" + gender + '\'' +
                ", weight=" + weight +
                ", height=" + height +
                ", contactNo='" + contactNo + '\'' +
                ", contactName='" + contactName + '\'' +
                '}';
    }
}
