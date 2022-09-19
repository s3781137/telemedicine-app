import 'package:flutter/material.dart';
import 'package:flutter_application/firstScreen.dart';
import 'package:flutter_application/patient/appointments.dart';
import 'package:flutter_application/patient/loginHome.dart';
import 'package:flutter_application/patient/register.dart';
import 'package:flutter_application/patient/screens/book_slots.dart';
import 'package:flutter_application/patient/screens/cancel_appointment.dart';
import 'package:flutter_application/patient/screens/view_appointment.dart';
import 'doctor/doctorSignUp.dart';
import 'patient/patient.dart';
import 'doctor/signIn.dart';
<<<<<<< Updated upstream
import 'patient/signUp.dart';
=======
import 'signUp.dart';
import 'patient/register.dart';
>>>>>>> Stashed changes
import 'doctor/welcome.dart';
import 'firstScreen.dart';

void main() {
  runApp(MaterialApp(
    title: 'My App',
    home: const firstScreen(),
    routes: {
      '/welcome': (context) => const WelcomeScreen(),
<<<<<<< Updated upstream
      '/patientsignup': (context) => const SignUpScreen(),
=======
      '/choosesignup': (context) => const RegisterHomeScreen(),
>>>>>>> Stashed changes
      '/doctorsignin': (context) => const SignInScreen(),
      '/doctorsignup': (context) => const DoctorSignUpScreen(),
      '/patient': (context) => const Patient(),
      '/loginhome': (context) => const LoginHome(),
      '/patient/appointments': (context) => const AppointmentsScreen(),
      '/patient/appointments/book': (context) => const BookAppointment(),
      '/patent/appointments/cancel': (context) =>
          const CancelAppointmentScreen(),
      '/patient/appointments/view': (context) => const ViewAppointmentScreen(),
    },
  ));
}
