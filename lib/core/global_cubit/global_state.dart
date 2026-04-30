part of 'global_cubit.dart';

class GlobalState extends Equatable {
  const GlobalState({required this.locale, required this.theme, this.profile});

  final Locale locale;
  final MorphemeTheme theme;
  final ProfileExtra? profile;

  GlobalState copyWith({
    Locale? locale,
    MorphemeTheme? theme,
    ProfileExtra? profile,
  }) {
    return GlobalState(
      locale: locale ?? this.locale,
      theme: theme ?? this.theme,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [locale, theme, profile];
}
