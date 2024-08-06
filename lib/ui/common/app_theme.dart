import 'package:flutter/material.dart';
import '/ui/common/index.dart';

class AppTheme {
  ThemeData appTheme() {
    return ThemeData(
      primaryColor: const Color.fromARGB(255, 196, 22, 28),
      scaffoldBackgroundColor: const Color.fromARGB(255, 250, 246, 240),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color.fromARGB(255, 250, 246, 240),
          background: const Color.fromARGB(255, 250, 246, 240)),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
            fontFamily: 'nexa-regular',
            color: Color.fromARGB(255, 105, 97, 94),
            fontSize: 15,
            fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(
            fontFamily: 'Nexa-Bold',
            color: Color.fromARGB(255, 148, 147, 146),
            fontSize: 10,
            fontWeight: FontWeight.w400),
        bodySmall: TextStyle(
            fontFamily: 'nexa-regular',
            color: Color.fromARGB(255, 66, 66, 66),
            fontSize: 8,
            fontWeight: FontWeight.w400),
        displayLarge: TextStyle(
          fontFamily: 'Nexa-Bold',
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          fontFamily: 'nexa-regular',
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Nexa-Bold',
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: TextStyle(
            fontFamily: 'Poppins',
            height: 1,
            color: Color.fromARGB(255, 255, 239, 184),
            fontSize: 15,
            fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(
            fontFamily: 'nexa-regular',
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 11,
            fontWeight: FontWeight.w400),
        headlineSmall: TextStyle(
            fontFamily: 'Nexa-Bold',
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 10,
            fontWeight: FontWeight.w400),
        labelLarge: TextStyle(
          fontFamily: 'Nexa-Bold',
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 196, 22, 28),
          fontSize: 18,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Nexa-Bold',
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 68, 68, 68),
          fontSize: 15,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Nexa-Bold',
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 171, 119, 14),
          fontSize: 13,
        ),
        titleLarge: TextStyle(
            fontFamily: 'Nexa-Light',
            color: Color.fromARGB(255, 68, 68, 68),
            fontSize: 11,
            fontWeight: FontWeight.w500),
        titleMedium: TextStyle(
            fontFamily: 'nexa-regular',
            color: Color.fromARGB(255, 68, 68, 68),
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w400),
        titleSmall: TextStyle(
            fontFamily: 'Nexa-Bold',
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 13,
            fontWeight: FontWeight.w400),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
        hintStyle: TextStyle(
            color: Color.fromARGB(102, 68, 68, 68),
            fontSize: 14,
            fontFamily: 'nexa-regular',
            fontWeight: FontWeight.w400),
        contentPadding: EdgeInsets.all(5),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
              fontFamily: 'Nexa-Bold',
              color: Color.fromARGB(255, 172, 119, 13),
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 45),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: const Color.fromARGB(255, 196, 22, 28),
          disabledBackgroundColor: blueShade300,
          disabledForegroundColor: whiteColor.withOpacity(0.6),
          textStyle: const TextStyle(
              fontFamily: 'Nexa-Bold',
              color: Color.fromARGB(255, 248, 248, 248),
              fontSize: 14,
              fontWeight: FontWeight.w400),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 45),
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 247, 148, 30),
          disabledBackgroundColor: blueShade300,
          disabledForegroundColor: whiteColor.withOpacity(0.6),
          side: BorderSide.none,
          textStyle: const TextStyle(
              fontFamily: 'Nexa-Bold',
              color: Color.fromARGB(255, 248, 248, 248),
              fontSize: 14,
              fontWeight: FontWeight.w400),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
    );
  }
}
