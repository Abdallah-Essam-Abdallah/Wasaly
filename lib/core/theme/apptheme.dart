import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primarySwatch: Colors.blueGrey,
  primaryColor: const Color.fromARGB(255, 138, 61, 16),
  scaffoldBackgroundColor: const Color.fromARGB(255, 238, 243, 243),
  fontFamily: 'Young Serif',
  dividerColor: Colors.grey,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    foregroundColor: Colors.black,
    backgroundColor: Colors.transparent,
    elevation: 0,
    toolbarHeight: kToolbarHeight,
    titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color.fromARGB(255, 61, 103, 109),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color.fromARGB(255, 61, 103, 109),
    shape: AutomaticNotchedShape(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)))),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
    elevation: 20,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    titleTextStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    contentTextStyle: TextStyle(
        fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Colors.grey,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5))),
    elevation: 5,
    // contentTextStyle: const TextStyle(color: Colors.white, fontSize: 20)
  ),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color?>(
    const Color.fromARGB(255, 61, 103, 109),
  ))),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color?>(
        const Color.fromARGB(255, 61, 103, 109),
      ),
      foregroundColor: MaterialStateProperty.all<Color?>(
          const Color.fromARGB(255, 255, 255, 255)),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color?>(
        const Color.fromARGB(255, 231, 141, 88)),
    shape: MaterialStateProperty.all(const CircleBorder()),
  )),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 110, 110, 110),
        fontSize: 20),
    headlineMedium: TextStyle(
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(225, 44, 44, 44),
        fontSize: 25),
    titleLarge: TextStyle(
        fontWeight: FontWeight.bold, color: Color.fromARGB(226, 39, 38, 38)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
    bodySmall: TextStyle(
        color: Color.fromARGB(255, 131, 131, 131), fontWeight: FontWeight.w500),
    labelLarge: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 17,
        fontWeight: FontWeight.w500),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    // elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    margin: const EdgeInsets.all(10),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromARGB(255, 61, 103, 109),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30))),
  ),

  /*tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      )),*/
);
