import 'package:equatable/equatable.dart';

class PokemonSpeciesEntity extends Equatable {
  const PokemonSpeciesEntity({
    this.eggGroups,
    this.hatchCounter,
    this.evolutionChain,
  });

  factory PokemonSpeciesEntity.dummy() => PokemonSpeciesEntity(
    eggGroups: [
      EggGroupsPokemonSpecies.dummy(),
      EggGroupsPokemonSpecies.dummy(),
    ],
    hatchCounter: 20,
    evolutionChain: EvolutionChainPokemonSpecies.dummy(),
  );

  final List<EggGroupsPokemonSpecies>? eggGroups;
  final int? hatchCounter;
  final EvolutionChainPokemonSpecies? evolutionChain;

  PokemonSpeciesEntity copyWith({
    List<EggGroupsPokemonSpecies>? eggGroups,
    int? hatchCounter,
    EvolutionChainPokemonSpecies? evolutionChain,
  }) {
    return PokemonSpeciesEntity(
      eggGroups: eggGroups ?? this.eggGroups,
      hatchCounter: hatchCounter ?? this.hatchCounter,
      evolutionChain: evolutionChain ?? this.evolutionChain,
    );
  }

  @override
  List<Object?> get props => [eggGroups, hatchCounter, evolutionChain];
}

class EggGroupsPokemonSpecies extends Equatable {
  const EggGroupsPokemonSpecies({this.name, this.url});

  factory EggGroupsPokemonSpecies.dummy() => EggGroupsPokemonSpecies(
    name: 'monster',
    url: 'https://pokeapi.co/api/v2/egg-group/1/',
  );

  final String? name;
  final String? url;

  EggGroupsPokemonSpecies copyWith({String? name, String? url}) {
    return EggGroupsPokemonSpecies(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => [name, url];
}

class EvolutionChainPokemonSpecies extends Equatable {
  const EvolutionChainPokemonSpecies({this.url});

  factory EvolutionChainPokemonSpecies.dummy() => EvolutionChainPokemonSpecies(
    url: 'https://pokeapi.co/api/v2/evolution-chain/1/',
  );

  final String? url;

  EvolutionChainPokemonSpecies copyWith({String? url}) {
    return EvolutionChainPokemonSpecies(url: url ?? this.url);
  }

  @override
  List<Object?> get props => [url];
}
