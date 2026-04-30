import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:poketter/core/extras/profile/profile_extra.dart';
import 'package:poketter/core/themes/morpheme_themes/morpheme_themes.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit()
    : super(
        GlobalState(locale: const Locale('id'), theme: MorphemeThemeDark()),
      );

  void changeLocale(Locale locale) => emit(state.copyWith(locale: locale));
  void changeTheme(MorphemeTheme theme) => emit(state.copyWith(theme: theme));
  void changeProfile(ProfileExtra profile) =>
      emit(state.copyWith(profile: profile));
}
