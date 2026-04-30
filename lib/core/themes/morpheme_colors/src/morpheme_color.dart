import 'package:flutter/material.dart';

extension MorphemeColorExtension on BuildContext {
  MorphemeColor get color => Theme.of(this).extension<MorphemeColor>()!;
}

class MorphemeColor extends ThemeExtension<MorphemeColor> {
  MorphemeColor({
    required this.primary,
    required this.secondary,
    required this.white,
    required this.background,
    required this.fillTextField,
    required this.border,
    required this.grey,
    required this.bgGrey,
    required this.info,
    required this.bgInfo,
    required this.error,
    required this.bgError,
    required this.success,
    required this.bgSuccess,
    required this.warning,
    required this.bgWarning,
    required this.black,
    required this.pureWhite,
    required this.transparent,
    required this.typeNormal,
    required this.typeFire,
    required this.typeWater,
    required this.typeElectric,
    required this.typeGrass,
    required this.typeIce,
    required this.typeFighting,
    required this.typePoison,
    required this.typeGround,
    required this.typeFlying,
    required this.typePsychic,
    required this.typeBug,
    required this.typeRock,
    required this.typeGhost,
    required this.typeDragon,
    required this.typeDark,
    required this.typeSteel,
    required this.typeFairy,
  });

  final Color primary;
  final Color secondary;
  final Color white;
  final Color background;
  final Color fillTextField;
  final Color border;
  final Color grey;
  final Color bgGrey;
  final Color info;
  final Color bgInfo;
  final Color error;
  final Color bgError;
  final Color success;
  final Color bgSuccess;
  final Color warning;
  final Color bgWarning;
  final Color black;
  final Color pureWhite;
  final Color transparent;
  final Color typeNormal;
  final Color typeFire;
  final Color typeWater;
  final Color typeElectric;
  final Color typeGrass;
  final Color typeIce;
  final Color typeFighting;
  final Color typePoison;
  final Color typeGround;
  final Color typeFlying;
  final Color typePsychic;
  final Color typeBug;
  final Color typeRock;
  final Color typeGhost;
  final Color typeDragon;
  final Color typeDark;
  final Color typeSteel;
  final Color typeFairy;

  @override
  MorphemeColor copyWith({
    Color? primary,
    Color? secondary,
    Color? white,
    Color? background,
    Color? fillTextField,
    Color? border,
    Color? grey,
    Color? bgGrey,
    Color? info,
    Color? bgInfo,
    Color? error,
    Color? bgError,
    Color? success,
    Color? bgSuccess,
    Color? warning,
    Color? bgWarning,
    Color? black,
    Color? pureWhite,
    Color? transparent,
    Color? typeNormal,
    Color? typeFire,
    Color? typeWater,
    Color? typeElectric,
    Color? typeGrass,
    Color? typeIce,
    Color? typeFighting,
    Color? typePoison,
    Color? typeGround,
    Color? typeFlying,
    Color? typePsychic,
    Color? typeBug,
    Color? typeRock,
    Color? typeGhost,
    Color? typeDragon,
    Color? typeDark,
    Color? typeSteel,
    Color? typeFairy,
  }) {
    return MorphemeColor(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      white: white ?? this.white,
      background: background ?? this.background,
      fillTextField: fillTextField ?? this.fillTextField,
      border: border ?? this.border,
      grey: grey ?? this.grey,
      bgGrey: bgGrey ?? this.bgGrey,
      info: info ?? this.info,
      bgInfo: bgInfo ?? this.bgInfo,
      error: error ?? this.error,
      bgError: bgError ?? this.bgError,
      success: success ?? this.success,
      bgSuccess: bgSuccess ?? this.bgSuccess,
      warning: warning ?? this.warning,
      bgWarning: bgWarning ?? this.bgWarning,
      black: black ?? this.black,
      pureWhite: pureWhite ?? this.pureWhite,
      transparent: transparent ?? this.transparent,
      typeNormal: typeNormal ?? this.typeNormal,
      typeFire: typeFire ?? this.typeFire,
      typeWater: typeWater ?? this.typeWater,
      typeElectric: typeElectric ?? this.typeElectric,
      typeGrass: typeGrass ?? this.typeGrass,
      typeIce: typeIce ?? this.typeIce,
      typeFighting: typeFighting ?? this.typeFighting,
      typePoison: typePoison ?? this.typePoison,
      typeGround: typeGround ?? this.typeGround,
      typeFlying: typeFlying ?? this.typeFlying,
      typePsychic: typePsychic ?? this.typePsychic,
      typeBug: typeBug ?? this.typeBug,
      typeRock: typeRock ?? this.typeRock,
      typeGhost: typeGhost ?? this.typeGhost,
      typeDragon: typeDragon ?? this.typeDragon,
      typeDark: typeDark ?? this.typeDark,
      typeSteel: typeSteel ?? this.typeSteel,
      typeFairy: typeFairy ?? this.typeFairy,
    );
  }

  @override
  MorphemeColor lerp(covariant MorphemeColor? other, double t) {
    if (other is! MorphemeColor) {
      return this;
    }

    return MorphemeColor(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      white: Color.lerp(white, other.white, t) ?? white,
      background: Color.lerp(background, other.background, t) ?? background,
      fillTextField:
          Color.lerp(fillTextField, other.fillTextField, t) ?? fillTextField,
      border: Color.lerp(border, other.border, t) ?? border,
      grey: Color.lerp(grey, other.grey, t) ?? grey,
      bgGrey: Color.lerp(bgGrey, other.bgGrey, t) ?? bgGrey,
      info: Color.lerp(info, other.info, t) ?? info,
      bgInfo: Color.lerp(bgInfo, other.bgInfo, t) ?? bgInfo,
      error: Color.lerp(error, other.error, t) ?? error,
      bgError: Color.lerp(bgError, other.bgError, t) ?? bgError,
      success: Color.lerp(success, other.success, t) ?? success,
      bgSuccess: Color.lerp(bgSuccess, other.bgSuccess, t) ?? bgSuccess,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      bgWarning: Color.lerp(bgWarning, other.bgWarning, t) ?? bgWarning,
      black: Color.lerp(black, other.black, t) ?? black,
      pureWhite: Color.lerp(pureWhite, other.pureWhite, t) ?? pureWhite,
      transparent: Color.lerp(transparent, other.transparent, t) ?? transparent,
      typeNormal: Color.lerp(typeNormal, other.typeNormal, t) ?? typeNormal,
      typeFire: Color.lerp(typeFire, other.typeFire, t) ?? typeFire,
      typeWater: Color.lerp(typeWater, other.typeWater, t) ?? typeWater,
      typeElectric:
          Color.lerp(typeElectric, other.typeElectric, t) ?? typeElectric,
      typeGrass: Color.lerp(typeGrass, other.typeGrass, t) ?? typeGrass,
      typeIce: Color.lerp(typeIce, other.typeIce, t) ?? typeIce,
      typeFighting:
          Color.lerp(typeFighting, other.typeFighting, t) ?? typeFighting,
      typePoison: Color.lerp(typePoison, other.typePoison, t) ?? typePoison,
      typeGround: Color.lerp(typeGround, other.typeGround, t) ?? typeGround,
      typeFlying: Color.lerp(typeFlying, other.typeFlying, t) ?? typeFlying,
      typePsychic: Color.lerp(typePsychic, other.typePsychic, t) ?? typePsychic,
      typeBug: Color.lerp(typeBug, other.typeBug, t) ?? typeBug,
      typeRock: Color.lerp(typeRock, other.typeRock, t) ?? typeRock,
      typeGhost: Color.lerp(typeGhost, other.typeGhost, t) ?? typeGhost,
      typeDragon: Color.lerp(typeDragon, other.typeDragon, t) ?? typeDragon,
      typeDark: Color.lerp(typeDark, other.typeDark, t) ?? typeDark,
      typeSteel: Color.lerp(typeSteel, other.typeSteel, t) ?? typeSteel,
      typeFairy: Color.lerp(typeFairy, other.typeFairy, t) ?? typeFairy,
    );
  }
}
