package com.sept.doctor.validator;

import javax.validation.Validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;

import com.sept.doctor.model.Doctor;

@Component
public class DoctorValidator implements org.springframework.validation.Validator {

    @Override
    public boolean supports(Class<?> aClass) {
        return Doctor.class.equals(aClass);
    }

    @Override
    public void validate(Object object, Errors errors) {

        Doctor doctor = (Doctor) object;

        if (doctor.getPassword().length() < 6) {
            errors.rejectValue("password", "Length", "Password must be at least 6 characters");
        }

        if (!doctor.getPassword().equals(doctor.getConfirmPassword())) {
            errors.rejectValue("confirmPassword", "Match", "Passwords must match");

        }

        // confirmPassword

    }

}
