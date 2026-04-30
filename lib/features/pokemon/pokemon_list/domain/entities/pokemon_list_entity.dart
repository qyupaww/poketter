import 'package:equatable/equatable.dart';

class PokemonListEntity extends Equatable {
  const PokemonListEntity({this.count, this.next, this.previous, this.results});

  factory PokemonListEntity.dummy() => PokemonListEntity(
    count: 1302,
    next: 'https://pokeapi.co/api/v2/pokemon?offset=20&limit=20',
    previous: null,
    results: [ResultsPokemonList.dummy()],
  );

  final int? count;
  final String? next;
  final dynamic previous;
  final List<ResultsPokemonList>? results;

  PokemonListEntity copyWith({
    int? count,
    String? next,
    dynamic previous,
    List<ResultsPokemonList>? results,
  }) {
    return PokemonListEntity(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [count, next, previous, results];
}

class ResultsPokemonList extends Equatable {
  const ResultsPokemonList({this.name, this.url});

  factory ResultsPokemonList.dummy() => ResultsPokemonList(
    name: 'bulbasaur',
    url: 'https://pokeapi.co/api/v2/pokemon/1/',
  );

  final String? name;
  final String? url;

  ResultsPokemonList copyWith({String? name, String? url}) {
    return ResultsPokemonList(name: name ?? this.name, url: url ?? this.url);
  }

  @override
  List<Object?> get props => [name, url];
}
