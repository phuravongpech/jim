import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jim/data/workout_data.dart';
import 'package:jim/screens/exercise/exercise_screen.dart';
import 'package:jim/screens/home/home_screen.dart';
import 'package:jim/services/cache_service.dart';
import 'package:jim/utils/color_theme.dart';
import 'screens/profile/profile_screen.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  Logger().d('Environment variables loaded');
  await CacheService.init();
  Logger().d('cache init');
  runApp(const JimApp());
}

class JimApp extends StatelessWidget {
  const JimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: secondaryColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: subTextColor,
          selectedLabelStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      home: const MainScreen(),
    );
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
        backgroundColor: secondaryColor,
        indicatorColor: const Color(0xFFB3E5FC),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.add_circle_outline), label: 'Exercise'),
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
        children: [
          const ExerciseScreen(),
          const HomeScreen(),
          ProfileScreen(user: user),
        ],
      ),
    );
  }
}
