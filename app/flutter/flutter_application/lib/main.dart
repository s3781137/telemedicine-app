import 'package:flutter/material.dart';
import 'package:flutter_application/admin/screens/login.dart';
import 'package:flutter_application/admin/screens/register.dart';
import 'package:flutter_application/doctor/doctorChat.dart';
import 'package:flutter_application/firstScreen.dart';
import 'package:flutter_application/patient/appointments.dart';
import 'package:flutter_application/patient/loginHome.dart';
import 'package:flutter_application/patient/register.dart';
import 'package:flutter_application/patient/screens/book_slots.dart';
import 'package:flutter_application/patient/screens/cancel_appointment.dart';
import 'package:flutter_application/patient/screens/medicine.dart';
import 'package:flutter_application/patient/screens/view_appointment.dart';
import 'doctor/doctorSignUp.dart';
import 'patient/patient.dart';
import 'doctor/signIn.dart';
import 'patient/register.dart';
import 'doctor/welcome.dart';
import 'firstScreen.dart';

//Tracks logged in users
var currentLoggedInUser = {"username": "", "userType": ""};

void main() {
  runApp(MaterialApp(
    title: 'ND TELEMEDICINE',
    //Sets the first page to be taken to, is defaulted to '/' directory so no need to add it to routes
    home: const firstScreen(),
    routes: {
      //Defining what url's show what screens
      '/welcome': (context) => const WelcomeScreen(),
      '/patientsignup': (context) => const RegisterHomeScreen(),
      '/doctorsignin': (context) => const SignInScreen(),
      '/doctorsignup': (context) => const DoctorSignUpScreen(),
      '/patient': (context) => Patient(),
      '/loginhome': (context) => const LoginHome(),
      '/patient/appointments': (context) => const AppointmentsScreen(),
      '/patient/appointments/book': (context) => const BookingSlotScreen(),
      '/patent/appointments/cancel': (context) => const CancelBookingScreen(),
      '/patient/appointments/view': (context) => const ViewBookingScreen(),
      '/patient/medicine': (context) => const ViewMedicineScreen(),
      '/doctor/chat': (context) => const doctorChat(),
      '/adminsignup': (context) => const AdminRegister(),
      '/adminsignin': (context) => AdminLogin(),
    },
  ));
}
