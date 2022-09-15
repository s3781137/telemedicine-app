package com.sept.telemedicine.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Column;

@Entity
@Table(name = "patient_health")
public class PatientHealthInfo {

    @Id
    private int id;
    private String cancer;
    private String diabetes;
    @Column(name = "heart_disease")
    private String heartDisease;
    @Column(name = "kidney_disease")
    private String kidneyDisease;
    @Column(name = "liver_disease")
    private String liverDisease;
    @Column(name = "medical_problems")
    private String medicalProblems;
    private String medication;
    @Column(name = "medication_description")
    private String medicationDescription;
    @Column(name = "past_surgeries")
    private String pastSurgeries;

    public PatientHealthInfo() {
    }

    public PatientHealthInfo(int id, String medication, String medicationDescription, String liverDisease,
            String kidneyDisease, String heartDisease, String diabetes, String cancer, String medicalProblems,
            String pastSurgeries) {
        this.id = id;
        this.medication = medication;
        this.medicationDescription = medicationDescription;
        this.liverDisease = liverDisease;
        this.kidneyDisease = kidneyDisease;
        this.heartDisease = heartDisease;
        this.diabetes = diabetes;
        this.cancer = cancer;
        this.medicalProblems = medicalProblems;
        this.pastSurgeries = pastSurgeries;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMedication() {
        return medication;
    }

    public void setMedication(String medication) {
        this.medication = medication;
    }

    public String getMedicationDescription() {
        return medicationDescription;
    }

    public void setMedicationDescription(String medicationDescription) {
        this.medicationDescription = medicationDescription;
    }

    public String getLiverDisease() {
        return liverDisease;
    }

    public void setLiverDisease(String liverDisease) {
        this.liverDisease = liverDisease;
    }

    public String getKidneyDisease() {
        return kidneyDisease;
    }

    public void setKidneyDisease(String kidneyDisease) {
        this.kidneyDisease = kidneyDisease;
    }

    public String getHeartDisease() {
        return heartDisease;
    }

    public void setHeartDisease(String heartDisease) {
        this.heartDisease = heartDisease;
    }

    public String getDiabetes() {
        return diabetes;
    }

    public void setDiabetes(String diabetes) {
        this.diabetes = diabetes;
    }

    public String getCancer() {
        return cancer;
    }

    public void setCancer(String cancer) {
        this.cancer = cancer;
    }

    public String getMedicalProblems() {
        return medicalProblems;
    }

    public void setMedicalProblems(String medicalProblems) {
        this.medicalProblems = medicalProblems;
    }

    public String getPastSurgeries() {
        return pastSurgeries;
    }

    public void setPastSurgeries(String pastSurgeries) {
        this.pastSurgeries = pastSurgeries;
    }

    @Override
    public String toString() {
        return "PatientHealthInfo [cancer=" + cancer + ", diabetes=" + diabetes + ", heartDisease=" + heartDisease
                + ", id=" + id + ", kidneyDisease=" + kidneyDisease + ", liverDisease=" + liverDisease
                + ", medicalProblems=" + medicalProblems + ", medication=" + medication + ", medicationDescription="
                + medicationDescription + ", pastSurgeries=" + pastSurgeries + "]";
    }

}
