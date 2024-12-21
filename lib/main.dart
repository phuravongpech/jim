import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jim/screens/home/home_screen.dart';

import 'package:logger/logger.dart';

import 'screens/profile/profile_screen.dart';

void main() {
  final logger = Logger();
  logger.d('hello');
  runApp(const JimApp());
}

class JimApp extends StatelessWidget {
  const JimApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        )
            // .copyWith(
            //     headlineMedium: GoogleFonts.openSans(
            //       fontSize: 32,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     // bodyMedium: GoogleFonts.roboto(fontSize: 18),
            //     ),
            ),
        home: const MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
        body: IndexedStack(
            index: currentPageIndex,
            children: const [HomeScreen(), ProfileScreen()]));
  }
}
