import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mansour_/shared/components/constans.dart';

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
  // primarySwatch: defaultColor,
  // floatingActionButtonTheme:
  //     FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20,
      backgroundColor: Colors.white),
  // fontFamily: 'Arima'
);

ThemeData darkTheme = ThemeData(
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
  scaffoldBackgroundColor: HexColor(
    '333739',
  ),
  // primarySwatch: defaultColor,
  // floatingActionButtonTheme:
  //     FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      backgroundColor: HexColor(
        '333739',
      ),
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor(
            '333739',
          ),
          statusBarIconBrightness: Brightness.light)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20,
    backgroundColor: HexColor(
      '333739',
    ),
  ),
  // fontFamily: 'Arima'
);
