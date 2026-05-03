part of 'pokemon_filter_cubit.dart';

class PokemonFilterState extends Equatable {
  const PokemonFilterState({
    this.generations,
    this.types,
    this.isLoading = false,
    this.errorMessage,
  });

  final List<dynamic>? generations;
  final List<dynamic>? types;
  final bool isLoading;
  final String? errorMessage;

  PokemonFilterState copyWith({
    List<dynamic>? generations,
    List<dynamic>? types,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PokemonFilterState(
      generations: generations ?? this.generations,
      types: types ?? this.types,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [generations, types, isLoading, errorMessage];
}
