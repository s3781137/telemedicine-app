package com.sept.telemedicine.Validator;

import com.sept.telemedicine.model.Patient;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import java.util.regex.*;    
import java.util.*;   

//this class checks if an account is valid for registration
@Component
public class UserValidator implements Validator {

    @Override
    public boolean supports(Class<?> aClass) {
        return Patient.class.equals(aClass);
    }

    @Override
    public void validate(Object object, Errors errors) {

        Patient user = (Patient) object;
        String regex = "^(.+)@(.+)$";
        Pattern pattern = Pattern.compile(regex);
;  
        //the password should be greater than 6
        if(user.getPassword().length() <6){
            errors.rejectValue("password","Length", "Password must be at least 6 characters");
        }

        //confirm password should match password
        if(!user.getPassword().equals(user.getConfirmPassword())){
            errors.rejectValue("confirmPassword","Match", "Passwords must match");
        }
        Matcher matcher = pattern.matcher(user.getEmail());
        
        //there should be an @ symbol for an email to be correct. 
        //checking if an email is correct
        if(!matcher.matches()){
            errors.rejectValue("email","Match", "Invalid email");
        }

        //confirmPassword



    }
}