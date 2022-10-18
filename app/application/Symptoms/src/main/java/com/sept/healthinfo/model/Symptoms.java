package com.sept.healthinfo.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity(name = "symptoms")
@Table(name = "symptoms")
public class Symptoms {
    @Id
    private int id;
    @Column(name = "pain_scale")
    private int painScale;
    @Column(name = "body_temperature")
    private double bodyTemperature;
    private String cough;
    @Column(name = "runny_nose")
    private boolean runnyNose;
    @Column(name = "username")
    private String userName;

    public Symptoms() {
    }

    public Symptoms(int painScale, double bodyTemperature, String cough, boolean runnyNose, String userName) {
        this.painScale = painScale;
        this.bodyTemperature = bodyTemperature;
        this.cough = cough;
        this.runnyNose = runnyNose;
        this.userName = userName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPainScale() {
        return painScale;
    }

    public void setPainScale(int painScale) {
        this.painScale = painScale;
    }

    public double getBodyTemperature() {
        return bodyTemperature;
    }

    public void setBodyTemperature(double bodyTemperature) {
        this.bodyTemperature = bodyTemperature;
    }

    public String getCough() {
        return cough;
    }

    public void setCough(String cough) {
        this.cough = cough;
    }

    public boolean isRunnyNose() {
        return runnyNose;
    }

    public void setRunnyNose(boolean runnyNose) {
        this.runnyNose = runnyNose;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

}
