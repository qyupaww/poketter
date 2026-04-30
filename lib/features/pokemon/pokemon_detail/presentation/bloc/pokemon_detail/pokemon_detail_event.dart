part of 'pokemon_detail_bloc.dart';

@immutable
abstract class PokemonDetailEvent extends Equatable {}

class FetchPokemonDetail extends PokemonDetailEvent {
  FetchPokemonDetail(this.body, {this.headers, this.extra, this.cacheStrategy});

  final PokemonDetailBody body;
  final Map<String, String>? headers;
  final dynamic extra;
  final CacheStrategy? cacheStrategy;

  @override
  List<Object?> get props => [body, headers, extra, cacheStrategy];
}

class CancelPokemonDetail extends PokemonDetailEvent {
  CancelPokemonDetail({this.extra});

  final dynamic extra;

  @override
  List<Object?> get props => [extra];
}
