part of 'pokemon_list_bloc.dart';

@immutable
abstract class PokemonListEvent extends Equatable {}

class FetchPokemonList extends PokemonListEvent {
  FetchPokemonList(this.body, {this.headers, this.extra, this.cacheStrategy});

  final PokemonListBody body;
  final Map<String, String>? headers;
  final dynamic extra;
  final CacheStrategy? cacheStrategy;

  @override
  List<Object?> get props => [body, headers, extra, cacheStrategy];
}

class CancelPokemonList extends PokemonListEvent {
  CancelPokemonList({this.extra});

  final dynamic extra;

  @override
  List<Object?> get props => [extra];
}
