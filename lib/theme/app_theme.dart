import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey[800],
    hintColor: Colors.amber,
    scaffoldBackgroundColor: Colors.black87,
    cardColor: Colors.grey[800],
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
      titleLarge: TextStyle(
          fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white70),
      bodyMedium:
          TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Colors.white70),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueGrey[700], // Background color for buttons
      textTheme: ButtonTextTheme.primary, // Text color for buttons
    ),
    appBarTheme: AppBarTheme(
      color: Colors.blueGrey[900],
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
        .copyWith(surface: Colors.black),
    // Add more theme customization as needed
  );
}
