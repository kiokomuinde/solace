// File: lib/main.dart
// This file sets up the main application, including the new darker color theme.

import 'package:flutter/material.dart';
import 'package:solace/screens/home_screen.dart';
import 'package:solace/screens/memorial_detail_screen.dart'; // Ensure this is imported for navigation
import 'package:solace/widgets/memorial_card.dart'; // This import is needed to recognize the MemorialCard widget.

// The main function is the entry point of the Flutter application.
void main() {
  runApp(const MemorialApp());
}

// Main application widget. It handles the theme and routes.
class MemorialApp extends StatelessWidget {
  const MemorialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solace',
      theme: ThemeData(
        // The darker, memorial theme.
        primarySwatch: Colors.brown,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37), // A beautiful, muted gold
          onPrimary: Color(0xFF45310F), // A dark brown for text
          secondary: Color(0xFF7D684D), // A warm, medium brown
          background: Color(0xFF45310F), // A deep, rich brown for the background
          surface: Color(0xFF5A442A), // A slightly lighter brown for cards and surfaces
          onSurface: Color(0xFFFBF8EE), // A creamy white for text on dark surfaces
        ),
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF45310F),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFFFBF8EE), // Creamy white for the title
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFBF8EE), // Creamy white for headlines
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFFE5D578), // A lighter gold for body text
            height: 1.5,
          ),
        ),
        cardTheme: const CardThemeData(
          color: Color(0xFF5A442A),
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD4AF37),
            foregroundColor: const Color(0xFF45310F),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
