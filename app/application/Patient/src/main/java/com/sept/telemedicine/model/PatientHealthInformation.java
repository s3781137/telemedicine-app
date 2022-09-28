// package com.sept.telemedicine.model;

// import javax.persistence.Entity;
// import javax.persistence.GeneratedValue;
// import javax.persistence.GenerationType;
// import javax.persistence.Id;
// import javax.persistence.Table;

// @Entity
// @Table(name = "patientHealth")
// public class PatientHealthInformation {

//     @Id
//     @GeneratedValue(strategy = GenerationType.IDENTITY)
//     private int id;
//     private boolean medication; 
//     private String medicationDescription;
//     private boolean liverDisease;
//     private boolean kidneyDisease;
//     private boolean heartDisease;
//     private boolean diabetes; 
//     private boolean cancer;
//     private String medicalProblems;
//     private String pastSurgeries;  

//     public PatientHealthInformation(int id, boolean medication, String medicationDescription, boolean liverDisease, boolean kidneyDisease, boolean heartDisease, boolean diabetes, boolean cancer, String medicalProblems, String pastSurgeries){
//         this.medication = medication;
//         this.medicationDescription = medicationDescription;
//         this.liverDisease = liverDisease;
//         this.kidneyDisease = kidneyDisease;
//         this.heartDisease = heartDisease;
//         this.diabetes= diabetes;
//         this.cancer = cancer;
//         this.medicalProblems = medicalProblems;
//         this.pastSurgeries = pastSurgeries;
//         this.id = id;
//     }

//     public boolean getMedication(){
//         return medication;
//     }

//     public int getId(){
//         return id;
//     }
//     public boolean getLiverDisease(){
//         return liverDisease;
//     }
//     public String getMedicalProblems(){
//         return medicalProblems;
//     }
//     public String getPastSurgeries(){
//         return pastSurgeries;
//     }
//     public String getMedicalDescription(){
//         return medicationDescription;
//     }
//     public boolean getCancer(){
//         return cancer;
//     }
//     public boolean getKidneyDisease(){
//         return kidneyDisease;
//     }

//     public boolean getHeartDisease(){
//         return heartDisease;
//     }

//     public boolean getDiabetes(){
//         return diabetes;
//     }

    
// }
