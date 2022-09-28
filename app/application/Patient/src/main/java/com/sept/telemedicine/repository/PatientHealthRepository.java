// package com.sept.telemedicine.repository;

// import com.sept.telemedicine.model.Patient;
// import com.sept.telemedicine.model.PatientHealthInformation;
// import org.springframework.data.jpa.repository.JpaRepository;
// import org.springframework.data.jpa.repository.Modifying;
// import org.springframework.data.jpa.repository.Query;
// import org.springframework.data.repository.query.Param;
// import org.springframework.stereotype.Repository;
// import org.springframework.transaction.annotation.Transactional;

// import java.util.Optional;

// @Repository
// public interface PatientHealthRepository extends JpaRepository<PatientHealthInformation, Integer> {

//     @Query("SELECT * FROM patientHealth WHERE id = ?1")
//     PatientHealthInformation getPatientHealth(@Param("username") int id);

//     @Modifying
//     @Query("UPDATE patientHealth SET medication = ?1, medicationDescription = ?2, liverDisease = ?3, kidneyDisease = ?4, heartDisease = ?5 diabetes = ?6, cancer = ?7, medicalProblems = ?8, pastSurgeries = ?9 WHERE id = ?10")
//     void updatePatientHealthDetails(
//             @Param("medication") boolean medication,
//             @Param("medicationDescription") String medicationDescription,
//             @Param("liverDisease") boolean liverDisease,
//             @Param("kidneyDisease") boolean kidneyDisease,
//             @Param("heartDisease") boolean heartDisease,
//             @Param("diabetes") boolean diabetes,
//             @Param("cancer") boolean cancer,
//             @Param("medicalProblems") String medicalProblems,
//             @Param("pastSurgeries") String pastSurgeries,
//             @Param("id") int id);

// }
