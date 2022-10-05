package com.sept.telemedicine;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

//main class used to run the telemedicine application
@SpringBootApplication
public class TelemedicineApplication implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(TelemedicineApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {

	}

}
