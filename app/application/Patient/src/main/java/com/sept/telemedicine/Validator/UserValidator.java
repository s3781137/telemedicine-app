package com.sept.telemedicine.Validator;

import com.sept.telemedicine.model.Patient;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import java.util.regex.*;    
import java.util.*;   

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

        if(user.getPassword().length() <6){
            errors.rejectValue("password","Length", "Password must be at least 6 characters");
        }

        if(!user.getPassword().equals(user.getConfirmPassword())){
            errors.rejectValue("confirmPassword","Match", "Passwords must match");
        }
        Matcher matcher = pattern.matcher(user.getEmail());
        
        //checking if an email is correct
        if(!matcher.matches()){
            errors.rejectValue("email","Match", "Invalid email");
        }

        //confirmPassword



    }
}