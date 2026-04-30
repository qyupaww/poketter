import 'dart:convert';

import 'package:equatable/equatable.dart';

class PokemonListResponse extends Equatable {
  const PokemonListResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PokemonListResponse.fromMap(Map<String, dynamic> map) {
    return PokemonListResponse(
      count: int.tryParse(map['count']?.toString() ?? ''),
      next: map['next'],
      previous: map['previous'],
      results: map['results'] is List
          ? List.from(
              (map['results'] as List)
                  .where((element) => element != null)
                  .map((e) => ResultsPokemonList.fromMap(e)),
            )
          : null,
    );
  }

  factory PokemonListResponse.fromJson(String source) =>
      PokemonListResponse.fromMap(json.decode(source));

  final int? count;
  final String? next;
  final dynamic previous;
  final List<ResultsPokemonList>? results;

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results?.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [count, next, previous, results];
}

class ResultsPokemonList extends Equatable {
  const ResultsPokemonList({this.name, this.url});

  factory ResultsPokemonList.fromMap(Map<String, dynamic> map) {
    return ResultsPokemonList(name: map['name'], url: map['url']);
  }

  factory ResultsPokemonList.fromJson(String source) =>
      ResultsPokemonList.fromMap(json.decode(source));

  final String? name;
  final String? url;

  Map<String, dynamic> toMap() {
    return {'name': name, 'url': url};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [name, url];
}
