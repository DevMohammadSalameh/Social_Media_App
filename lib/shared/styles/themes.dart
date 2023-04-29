
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData LightTheme(context)=> ThemeData(

  // textTheme: GoogleFonts.playfairDisplayScTextTheme(
  //   Theme.of(context).textTheme,
  // ),
  appBarTheme:  AppBarTheme(
    titleTextStyle: GoogleFonts.playfairDisplay(
      textStyle: const TextStyle(
            fontSize: 20.0,
      ),
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    color: primaryColor,
  ),
  scaffoldBackgroundColor: Colors.grey[300],
  primarySwatch: secondaryColor,
);

ThemeData DarkTheme(context)=> ThemeData(

  appBarTheme:  AppBarTheme(
    titleTextStyle: GoogleFonts.playfairDisplay(
      textStyle: const TextStyle(
        fontSize: 20.0,
      ),
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    color: primaryColor[900],
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  textTheme: GoogleFonts.playfairDisplayScTextTheme(
    Theme.of(context).textTheme,
  ),
  primarySwatch: secondaryColor,
);