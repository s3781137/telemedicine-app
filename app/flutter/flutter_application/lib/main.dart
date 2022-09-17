import 'package:flutter/material.dart';
import 'package:flutter_application/firstScreen.dart';
import 'package:flutter_application/patient/Bloc/MainBloc.dart';
import 'package:flutter_application/patient/appointments.dart';
import 'package:flutter_application/patient/loginHome.dart';
import 'package:flutter_application/patient/screens/book_slots.dart';
import 'package:flutter_application/patient/screens/cancel_appointment.dart';
import 'package:flutter_application/patient/screens/view_appointment.dart';
import 'doctor/doctorSignUp.dart';
import 'patient/patient.dart';
import 'doctor/signIn.dart';
import 'signUp.dart';
import 'doctor/welcome.dart';
import 'firstScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => MainBloc())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: context.watch<MainBloc>().user == null ? LoginHome() : Patient(),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/choosesignup': (context) => const SignUpScreen(),
        '/doctorsignin': (context) => const SignInScreen(),
        '/doctorsignup': (context) => const DoctorSignUpScreen(),
        '/patient': (context) => const Patient(),
        '/loginhome': (context) => const LoginHome(),
        '/patient/appointments': (context) => const AppointmentsScreen(),
        '/patient/appointments/book': (context) => const BookAppointment(),
        '/patent/appointments/cancel': (context) =>
            const CancelAppointmentScreen(),
        '/patient/appointments/view': (context) =>
            const ViewAppointmentScreen(),
      },
    );
  }
}
