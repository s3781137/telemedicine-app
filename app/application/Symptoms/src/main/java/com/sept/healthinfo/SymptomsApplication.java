package com.sept.healthinfo;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SymptomsApplication implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(SymptomsApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {

	}
}
