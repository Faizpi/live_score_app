import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_score/screens/home_screen.dart';
import 'package:live_score/screens/onboarding_screen.dart';

// Definisikan warna utama agar mudah diakses
class AppColors {
  static const Color background = Color.fromARGB(255, 0, 0, 0);
  static const Color cardBackground = Color(0xFF252E2A);
  static const Color primaryGreen = Color(0xFFADFF2F);
  static const Color textWhite = Colors.white;
  static const Color textGrey = Colors.grey;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Tema dasar yang akan digunakan di seluruh aplikasi
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Live Score UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primaryGreen,
        // Perubahan: Terapkan font Poppins ke seluruh aplikasi
        textTheme: GoogleFonts.poppinsTextTheme(textTheme).apply(
          bodyColor: AppColors.textWhite,
          displayColor: AppColors.textWhite,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const OnboardingScreen(),
      routes: {'/home': (context) => const HomeScreen()},
    );
  }
}
