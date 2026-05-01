part of 'pokemon_species_bloc.dart';

@immutable
abstract class PokemonSpeciesEvent extends Equatable {}

class FetchPokemonSpecies extends PokemonSpeciesEvent {
  FetchPokemonSpecies(
    this.body, {
    this.headers,
    this.extra,
    this.cacheStrategy,
  });

  final PokemonSpeciesBody body;
  final Map<String, String>? headers;
  final dynamic extra;
  final CacheStrategy? cacheStrategy;

  @override
  List<Object?> get props => [body, headers, extra, cacheStrategy];
}

class CancelPokemonSpecies extends PokemonSpeciesEvent {
  CancelPokemonSpecies({this.extra});

  final dynamic extra;

  @override
  List<Object?> get props => [extra];
}
