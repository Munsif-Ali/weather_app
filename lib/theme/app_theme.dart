import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      onPrimary: Colors.white,
      secondary: Colors.amber,
      surfaceContainer: Colors.grey,
      onSurface: Colors.black87,
    ),
    useMaterial3: true,
    cardColor: Colors.white.withAlpha(100),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.blue.shade300,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 2.0,
        ),
      ),
      errorMaxLines: 2,
      errorStyle: TextStyle(
        color: Colors.red.shade300,
        fontSize: 12,
      ),
      isDense: true,
      hintStyle: TextStyle(
        fontStyle: FontStyle.italic,
      ),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.blueGrey,
      onPrimary: Colors.white,
      secondary: Colors.teal,
      surfaceContainer: Colors.black,
      onSurface: Colors.white,
    ),
    cardColor: Colors.black.withAlpha(100),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.blue.shade300,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 2.0,
          color: Colors.blue.shade300,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 1.5,
          color: Colors.red.shade300,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 2.0,
          color: Colors.red.shade300,
        ),
      ),
      hintStyle: TextStyle(
        fontStyle: FontStyle.italic,
      ),
      errorMaxLines: 3,
      errorStyle: TextStyle(
        color: Colors.red.shade300,
        fontSize: 12,
      ),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
