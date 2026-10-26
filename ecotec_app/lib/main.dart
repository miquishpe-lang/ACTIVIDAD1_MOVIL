import 'package:flutter/material.dart'; //librería de flutter
import 'screens/home_screen.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFFF8C00);
    const darkCyan = Color(0xFF008B8B);
    return MaterialApp(
      title: 'Portafolio de Mike',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: orange).copyWith(
          primary: orange,
          secondary: darkCyan,
          surface: const Color(0xFFF4F5F7),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F5F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF20242B),
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
