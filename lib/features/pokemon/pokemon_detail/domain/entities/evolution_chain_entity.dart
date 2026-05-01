import 'package:equatable/equatable.dart';

class EvolutionChainEntity extends Equatable {
  const EvolutionChainEntity({this.chain});

  factory EvolutionChainEntity.dummy() =>
      EvolutionChainEntity(chain: ChainEvolutionChain.dummy());

  final ChainEvolutionChain? chain;

  EvolutionChainEntity copyWith({ChainEvolutionChain? chain}) {
    return EvolutionChainEntity(chain: chain ?? this.chain);
  }

  @override
  List<Object?> get props => [chain];
}

class ChainEvolutionChain extends Equatable {
  const ChainEvolutionChain({
    this.evolutionDetails,
    this.evolvesTo,
    this.species,
  });

  factory ChainEvolutionChain.dummy() => ChainEvolutionChain(
    evolutionDetails: [],
    evolvesTo: [EvolvesToEvolutionChain.dummy()],
    species: SpeciesEvolutionChain.dummy(),
  );

  final List<dynamic>? evolutionDetails;
  final List<EvolvesToEvolutionChain>? evolvesTo;
  final SpeciesEvolutionChain? species;

  ChainEvolutionChain copyWith({
    List<dynamic>? evolutionDetails,
    List<EvolvesToEvolutionChain>? evolvesTo,
    SpeciesEvolutionChain? species,
  }) {
    return ChainEvolutionChain(
      evolutionDetails: evolutionDetails ?? this.evolutionDetails,
      evolvesTo: evolvesTo ?? this.evolvesTo,
      species: species ?? this.species,
    );
  }

  @override
  List<Object?> get props => [evolutionDetails, evolvesTo, species];
}

class EvolvesToEvolutionChain extends Equatable {
  const EvolvesToEvolutionChain({
    this.evolutionDetails,
    this.evolvesTo,
    this.species,
  });

  factory EvolvesToEvolutionChain.dummy() => EvolvesToEvolutionChain(
    evolutionDetails: [EvolutionDetailsEvolutionChain.dummy()],
    evolvesTo: [AlphaEvolvesToEvolutionChain.dummy()],
    species: SpeciesEvolutionChain.dummy(),
  );

  final List<EvolutionDetailsEvolutionChain>? evolutionDetails;
  final List<AlphaEvolvesToEvolutionChain>? evolvesTo;
  final SpeciesEvolutionChain? species;

  EvolvesToEvolutionChain copyWith({
    List<EvolutionDetailsEvolutionChain>? evolutionDetails,
    List<AlphaEvolvesToEvolutionChain>? evolvesTo,
    SpeciesEvolutionChain? species,
  }) {
    return EvolvesToEvolutionChain(
      evolutionDetails: evolutionDetails ?? this.evolutionDetails,
      evolvesTo: evolvesTo ?? this.evolvesTo,
      species: species ?? this.species,
    );
  }

  @override
  List<Object?> get props => [evolutionDetails, evolvesTo, species];
}

class EvolutionDetailsEvolutionChain extends Equatable {
  const EvolutionDetailsEvolutionChain({this.minLevel, this.trigger});

  factory EvolutionDetailsEvolutionChain.dummy() =>
      EvolutionDetailsEvolutionChain(
        minLevel: 16,
        trigger: TriggerEvolutionChain.dummy(),
      );

  final int? minLevel;
  final TriggerEvolutionChain? trigger;

  EvolutionDetailsEvolutionChain copyWith({
    int? minLevel,
    TriggerEvolutionChain? trigger,
  }) {
    return EvolutionDetailsEvolutionChain(
      minLevel: minLevel ?? this.minLevel,
      trigger: trigger ?? this.trigger,
    );
  }

  @override
  List<Object?> get props => [minLevel, trigger];
}

class TriggerEvolutionChain extends Equatable {
  const TriggerEvolutionChain({this.name});

  factory TriggerEvolutionChain.dummy() =>
      TriggerEvolutionChain(name: 'level-up');

  final String? name;

  TriggerEvolutionChain copyWith({String? name}) {
    return TriggerEvolutionChain(name: name ?? this.name);
  }

  @override
  List<Object?> get props => [name];
}

class AlphaEvolvesToEvolutionChain extends Equatable {
  const AlphaEvolvesToEvolutionChain({
    this.evolutionDetails,
    this.evolvesTo,
    this.species,
  });

  factory AlphaEvolvesToEvolutionChain.dummy() => AlphaEvolvesToEvolutionChain(
    evolutionDetails: [AlphaEvolutionDetailsEvolutionChain.dummy()],
    evolvesTo: [],
    species: SpeciesEvolutionChain.dummy(),
  );

  final List<AlphaEvolutionDetailsEvolutionChain>? evolutionDetails;
  final List<dynamic>? evolvesTo;
  final SpeciesEvolutionChain? species;

  AlphaEvolvesToEvolutionChain copyWith({
    List<AlphaEvolutionDetailsEvolutionChain>? evolutionDetails,
    List<dynamic>? evolvesTo,
    SpeciesEvolutionChain? species,
  }) {
    return AlphaEvolvesToEvolutionChain(
      evolutionDetails: evolutionDetails ?? this.evolutionDetails,
      evolvesTo: evolvesTo ?? this.evolvesTo,
      species: species ?? this.species,
    );
  }

  @override
  List<Object?> get props => [evolutionDetails, evolvesTo, species];
}

class AlphaEvolutionDetailsEvolutionChain extends Equatable {
  const AlphaEvolutionDetailsEvolutionChain({this.minLevel, this.trigger});

  factory AlphaEvolutionDetailsEvolutionChain.dummy() =>
      AlphaEvolutionDetailsEvolutionChain(
        minLevel: 32,
        trigger: AlphaTriggerEvolutionChain.dummy(),
      );

  final int? minLevel;
  final AlphaTriggerEvolutionChain? trigger;

  AlphaEvolutionDetailsEvolutionChain copyWith({
    int? minLevel,
    AlphaTriggerEvolutionChain? trigger,
  }) {
    return AlphaEvolutionDetailsEvolutionChain(
      minLevel: minLevel ?? this.minLevel,
      trigger: trigger ?? this.trigger,
    );
  }

  @override
  List<Object?> get props => [minLevel, trigger];
}

class AlphaTriggerEvolutionChain extends Equatable {
  const AlphaTriggerEvolutionChain({this.name});

  factory AlphaTriggerEvolutionChain.dummy() =>
      AlphaTriggerEvolutionChain(name: 'level-up');

  final String? name;

  AlphaTriggerEvolutionChain copyWith({String? name}) {
    return AlphaTriggerEvolutionChain(name: name ?? this.name);
  }

  @override
  List<Object?> get props => [name];
}

class SpeciesEvolutionChain extends Equatable {
  const SpeciesEvolutionChain({this.name, this.url});

  factory SpeciesEvolutionChain.dummy() => SpeciesEvolutionChain(
    name: 'venusaur',
    url: 'https://pokeapi.co/api/v2/pokemon-species/3/',
  );

  final String? name;
  final String? url;

  SpeciesEvolutionChain copyWith({String? name, String? url}) {
    return SpeciesEvolutionChain(name: name ?? this.name, url: url ?? this.url);
  }

  @override
  List<Object?> get props => [name, url];
}

class AlphaSpeciesEvolutionChain extends Equatable {
  const AlphaSpeciesEvolutionChain({this.name, this.url});

  factory AlphaSpeciesEvolutionChain.dummy() => AlphaSpeciesEvolutionChain(
    name: 'ivysaur',
    url: 'https://pokeapi.co/api/v2/pokemon-species/2/',
  );

  final String? name;
  final String? url;

  AlphaSpeciesEvolutionChain copyWith({String? name, String? url}) {
    return AlphaSpeciesEvolutionChain(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => [name, url];
}

class BetaSpeciesEvolutionChain extends Equatable {
  const BetaSpeciesEvolutionChain({this.name, this.url});

  factory BetaSpeciesEvolutionChain.dummy() => BetaSpeciesEvolutionChain(
    name: 'bulbasaur',
    url: 'https://pokeapi.co/api/v2/pokemon-species/1/',
  );

  final String? name;
  final String? url;

  BetaSpeciesEvolutionChain copyWith({String? name, String? url}) {
    return BetaSpeciesEvolutionChain(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => [name, url];
}
