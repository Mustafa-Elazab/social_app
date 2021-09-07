import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/shared/styles/color.dart';



ThemeData lightTheme =ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade200,
  primaryColor: kPrimaryColor,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: kPrimaryColor, statusBarBrightness: Brightness.dark),
    color: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Lato-Regular'
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: kContentColorLightTheme.withOpacity(0.7),
    unselectedItemColor: kContentColorLightTheme.withOpacity(0.32),
    selectedIconTheme: IconThemeData(color: kPrimaryColor),
    showUnselectedLabels: true,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.w600
    ),
      bodyText2: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontFamily: 'Anton-Regular'
      )
  ),
  colorScheme: ColorScheme.light(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
    error: kErrorColor,
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor:kContentColorLightTheme,
  primaryColor: kPrimaryColor,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: kPrimaryColor, statusBarBrightness: Brightness.light),
    color:kContentColorLightTheme,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
        fontFamily: 'Lato-Regular'
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize:14,
      ),
      bodyText2: TextStyle(
        fontSize: 18,
        color: Colors.white,
          fontFamily: 'Anton-Regular'
      )
    ),
    iconTheme: IconThemeData(
        color: kContentColorDarkTheme
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: kContentColorLightTheme,
    selectedItemColor: Colors.white70,
    unselectedItemColor: kContentColorDarkTheme.withOpacity(0.32),
    selectedIconTheme: IconThemeData(color: kPrimaryColor),
    showUnselectedLabels: true,
  ),

  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
  ),
  colorScheme: ColorScheme.dark().copyWith(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
    error: kErrorColor,
  ),
);