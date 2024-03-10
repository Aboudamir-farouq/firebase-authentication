import 'package:firebase_authentication/screens/home_screen.dart';
import 'package:firebase_authentication/screens/login_screen.dart';
import 'package:firebase_authentication/services/firebase_auth_service.dart';
import 'package:firebase_authentication/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (FirebaseAuthService.isUserConnected()) {
        NavigationService.navigateTo(context, const HomeScreen());
      } else {
        NavigationService.navigateTo(context, const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 49, 158, 247),
              Colors.blue,
            ],
          ),
        ),
        child: Center(
          child: Text(
            'Firebase\nAuth',
            textAlign: TextAlign.center,
            style: GoogleFonts.lobster(
              color: Colors.white,
              fontSize: 40
            ),
          ) 
        ),
      ),
    );
  }
}