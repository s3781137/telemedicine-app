package com.sept.healthinfo.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.sept.healthinfo.model.Symptoms;

@Repository
public interface SymptomsRepository extends JpaRepository<Symptoms, Integer> {

    @Query(value = "SELECT * FROM symptoms s WHERE s.username = ?1", nativeQuery = true)
    Symptoms findSymptomsByUsername(String username);
}
