import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poketter/core/constants/constant_radius.dart';
import 'package:poketter/core/themes/morpheme_colors/src/morpheme_color.dart';

abstract base class MorphemeTheme {
  MorphemeTheme(this.id);

  final String id;

  MorphemeColor get color;
  ThemeData get rawThemeData;
  ColorScheme get colorScheme;

  TextTheme get _getTextTheme => GoogleFonts.interTextTheme().apply(
    bodyColor: color.white,
    displayColor: color.white,
  );

  ThemeData get themeData => rawThemeData.copyWith(
    extensions: [color],
    scaffoldBackgroundColor: color.background,
    colorScheme: colorScheme,
    textTheme: _getTextTheme,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: color.background,
      selectedItemColor: color.primary,
      unselectedItemColor: color.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: color.background,
      surfaceTintColor: color.background,
      foregroundColor: color.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.primary,
        foregroundColor: color.background,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConstantRadius.r12),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: color.primary,
        side: BorderSide(color: color.border),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConstantRadius.r12),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: color.primary,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConstantRadius.r12),
        ),
      ),
    ),
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MorphemeTheme && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
