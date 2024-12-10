import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jim/components/workout_log.dart';
import 'package:jim/components/workout_screen.dart';
import 'components/home_screen.dart';
import 'components/profile_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: TextTheme(
        headlineMedium: GoogleFonts.poppins(
            fontSize: 32, fontWeight: FontWeight.bold), // For larger headings
        bodyMedium: GoogleFonts.poppins(fontSize: 18), // For body text
        // You can define more styles here if needed
      ),
    ),
    home: Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          centerTitle: true,
          title: Image.asset(
            'assets/logos/logo1.png',
            width: 80,
          ),
          shadowColor: Colors.black,
        ),
        body:
            // const ProfileScreen()
            // const WorkoutScreen()
            // const HomeScreen()),
            const WorkoutLogScreen()),
  ));
}
