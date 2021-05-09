import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_factory/helper/custome_transition.dart';

class MyTheme {
  static ThemeData darkTheme(BuildContext context) => ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
        accentColor: Colors.purpleAccent,
        colorScheme: ColorScheme.dark(),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.purpleAccent),
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation: 0.0,
        ),
        cardColor: Colors.grey[900],
        dividerColor: Colors.grey,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          },
        ),
      );

  static ThemeData lightTheme(BuildContext context) => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.purpleAccent,
        accentColor: Colors.purpleAccent,
        colorScheme: ColorScheme.light(),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.purpleAccent),
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: Theme.of(context).iconTheme,
          textTheme: Theme.of(context).textTheme,
        ),
        cardColor: Colors.grey[100],
        dividerColor: Colors.grey,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          },
        ),
      );
}
