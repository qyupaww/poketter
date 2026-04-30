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
  const ResultsPokemonList({this.name, this.url, this.types, this.imageUrl});

  factory ResultsPokemonList.dummy() => ResultsPokemonList(
    name: 'bulbasaur',
    url: 'https://pokeapi.co/api/v2/pokemon/1/',
    types: const ['grass', 'poison'],
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
  );

  final String? name;
  final String? url;
  final List<String>? types;
  final String? imageUrl;

  ResultsPokemonList copyWith({
    String? name,
    String? url,
    List<String>? types,
    String? imageUrl,
  }) {
    return ResultsPokemonList(
      name: name ?? this.name,
      url: url ?? this.url,
      types: types ?? this.types,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [name, url, types, imageUrl];
}
