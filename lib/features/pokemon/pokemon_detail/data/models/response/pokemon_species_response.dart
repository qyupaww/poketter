import 'dart:convert';

import 'package:equatable/equatable.dart';

class PokemonSpeciesResponse extends Equatable {
  const PokemonSpeciesResponse({
    this.eggGroups,
    this.hatchCounter,
    this.evolutionChain,
  });

  factory PokemonSpeciesResponse.fromMap(Map<String, dynamic> map) {
    return PokemonSpeciesResponse(
      eggGroups: map['egg_groups'] is List
          ? List.from(
              (map['egg_groups'] as List)
                  .where((element) => element != null)
                  .map((e) => EggGroupsPokemonSpecies.fromMap(e)),
            )
          : null,
      hatchCounter: int.tryParse(map['hatch_counter']?.toString() ?? ''),
      evolutionChain: map['evolution_chain'] == null
          ? null
          : EvolutionChainPokemonSpecies.fromMap(map['evolution_chain']),
    );
  }

  factory PokemonSpeciesResponse.fromJson(String source) =>
      PokemonSpeciesResponse.fromMap(json.decode(source));

  final List<EggGroupsPokemonSpecies>? eggGroups;
  final int? hatchCounter;
  final EvolutionChainPokemonSpecies? evolutionChain;

  Map<String, dynamic> toMap() {
    return {
      'egg_groups': eggGroups?.map((e) => e.toMap()).toList(),
      'hatch_counter': hatchCounter,
      'evolution_chain': evolutionChain?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [eggGroups, hatchCounter, evolutionChain];
}

class EggGroupsPokemonSpecies extends Equatable {
  const EggGroupsPokemonSpecies({this.name, this.url});

  factory EggGroupsPokemonSpecies.fromMap(Map<String, dynamic> map) {
    return EggGroupsPokemonSpecies(name: map['name'], url: map['url']);
  }

  factory EggGroupsPokemonSpecies.fromJson(String source) =>
      EggGroupsPokemonSpecies.fromMap(json.decode(source));

  final String? name;
  final String? url;

  Map<String, dynamic> toMap() {
    return {'name': name, 'url': url};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [name, url];
}

class EvolutionChainPokemonSpecies extends Equatable {
  const EvolutionChainPokemonSpecies({this.url});

  factory EvolutionChainPokemonSpecies.fromMap(Map<String, dynamic> map) {
    return EvolutionChainPokemonSpecies(url: map['url']);
  }

  factory EvolutionChainPokemonSpecies.fromJson(String source) =>
      EvolutionChainPokemonSpecies.fromMap(json.decode(source));

  final String? url;

  Map<String, dynamic> toMap() {
    return {'url': url};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [url];
}
