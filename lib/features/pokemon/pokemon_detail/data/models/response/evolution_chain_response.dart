import 'dart:convert';

import 'package:equatable/equatable.dart';

class EvolutionChainResponse extends Equatable {
  const EvolutionChainResponse({this.chain});

  factory EvolutionChainResponse.fromMap(Map<String, dynamic> map) {
    return EvolutionChainResponse(
      chain: map['chain'] == null
          ? null
          : ChainEvolutionChain.fromMap(map['chain']),
    );
  }

  factory EvolutionChainResponse.fromJson(String source) =>
      EvolutionChainResponse.fromMap(json.decode(source));

  final ChainEvolutionChain? chain;

  Map<String, dynamic> toMap() {
    return {'chain': chain?.toMap()};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [chain];
}

class ChainEvolutionChain extends Equatable {
  const ChainEvolutionChain({
    this.evolutionDetails,
    this.evolvesTo,
    this.species,
  });

  factory ChainEvolutionChain.fromMap(Map<String, dynamic> map) {
    return ChainEvolutionChain(
      evolutionDetails: map['evolution_details'],
      evolvesTo: map['evolves_to'] is List
          ? List.from(
              (map['evolves_to'] as List)
                  .where((element) => element != null)
                  .map((e) => EvolvesToEvolutionChain.fromMap(e)),
            )
          : null,
      species: map['species'] == null
          ? null
          : SpeciesEvolutionChain.fromMap(map['species']),
    );
  }

  factory ChainEvolutionChain.fromJson(String source) =>
      ChainEvolutionChain.fromMap(json.decode(source));

  final List<dynamic>? evolutionDetails;
  final List<EvolvesToEvolutionChain>? evolvesTo;
  final SpeciesEvolutionChain? species;

  Map<String, dynamic> toMap() {
    return {
      'evolution_details': evolutionDetails,
      'evolves_to': evolvesTo?.map((e) => e.toMap()).toList(),
      'species': species?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [evolutionDetails, evolvesTo, species];
}

class EvolvesToEvolutionChain extends Equatable {
  const EvolvesToEvolutionChain({
    this.evolutionDetails,
    this.evolvesTo,
    this.species,
  });

  factory EvolvesToEvolutionChain.fromMap(Map<String, dynamic> map) {
    return EvolvesToEvolutionChain(
      evolutionDetails: map['evolution_details'] is List
          ? List.from(
              (map['evolution_details'] as List)
                  .where((element) => element != null)
                  .map((e) => EvolutionDetailsEvolutionChain.fromMap(e)),
            )
          : null,
      evolvesTo: map['evolves_to'] is List
          ? List.from(
              (map['evolves_to'] as List)
                  .where((element) => element != null)
                  .map((e) => AlphaEvolvesToEvolutionChain.fromMap(e)),
            )
          : null,
      species: map['species'] == null
          ? null
          : SpeciesEvolutionChain.fromMap(map['species']),
    );
  }

  factory EvolvesToEvolutionChain.fromJson(String source) =>
      EvolvesToEvolutionChain.fromMap(json.decode(source));

  final List<EvolutionDetailsEvolutionChain>? evolutionDetails;
  final List<AlphaEvolvesToEvolutionChain>? evolvesTo;
  final SpeciesEvolutionChain? species;

  Map<String, dynamic> toMap() {
    return {
      'evolution_details': evolutionDetails?.map((e) => e.toMap()).toList(),
      'evolves_to': evolvesTo?.map((e) => e.toMap()).toList(),
      'species': species?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [evolutionDetails, evolvesTo, species];
}

class EvolutionDetailsEvolutionChain extends Equatable {
  const EvolutionDetailsEvolutionChain({this.minLevel, this.trigger});

  factory EvolutionDetailsEvolutionChain.fromMap(Map<String, dynamic> map) {
    return EvolutionDetailsEvolutionChain(
      minLevel: int.tryParse(map['min_level']?.toString() ?? ''),
      trigger: map['trigger'] == null
          ? null
          : TriggerEvolutionChain.fromMap(map['trigger']),
    );
  }

  factory EvolutionDetailsEvolutionChain.fromJson(String source) =>
      EvolutionDetailsEvolutionChain.fromMap(json.decode(source));

  final int? minLevel;
  final TriggerEvolutionChain? trigger;

  Map<String, dynamic> toMap() {
    return {'min_level': minLevel, 'trigger': trigger?.toMap()};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [minLevel, trigger];
}

class TriggerEvolutionChain extends Equatable {
  const TriggerEvolutionChain({this.name});

  factory TriggerEvolutionChain.fromMap(Map<String, dynamic> map) {
    return TriggerEvolutionChain(name: map['name']);
  }

  factory TriggerEvolutionChain.fromJson(String source) =>
      TriggerEvolutionChain.fromMap(json.decode(source));

  final String? name;

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [name];
}

class AlphaEvolvesToEvolutionChain extends Equatable {
  const AlphaEvolvesToEvolutionChain({
    this.evolutionDetails,
    this.evolvesTo,
    this.species,
  });

  factory AlphaEvolvesToEvolutionChain.fromMap(Map<String, dynamic> map) {
    return AlphaEvolvesToEvolutionChain(
      evolutionDetails: map['evolution_details'] is List
          ? List.from(
              (map['evolution_details'] as List)
                  .where((element) => element != null)
                  .map((e) => AlphaEvolutionDetailsEvolutionChain.fromMap(e)),
            )
          : null,
      evolvesTo: map['evolves_to'],
      species: map['species'] == null
          ? null
          : SpeciesEvolutionChain.fromMap(map['species']),
    );
  }

  factory AlphaEvolvesToEvolutionChain.fromJson(String source) =>
      AlphaEvolvesToEvolutionChain.fromMap(json.decode(source));

  final List<AlphaEvolutionDetailsEvolutionChain>? evolutionDetails;
  final List<dynamic>? evolvesTo;
  final SpeciesEvolutionChain? species;

  Map<String, dynamic> toMap() {
    return {
      'evolution_details': evolutionDetails?.map((e) => e.toMap()).toList(),
      'evolves_to': evolvesTo,
      'species': species?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [evolutionDetails, evolvesTo, species];
}

class AlphaEvolutionDetailsEvolutionChain extends Equatable {
  const AlphaEvolutionDetailsEvolutionChain({this.minLevel, this.trigger});

  factory AlphaEvolutionDetailsEvolutionChain.fromMap(
    Map<String, dynamic> map,
  ) {
    return AlphaEvolutionDetailsEvolutionChain(
      minLevel: int.tryParse(map['min_level']?.toString() ?? ''),
      trigger: map['trigger'] == null
          ? null
          : AlphaTriggerEvolutionChain.fromMap(map['trigger']),
    );
  }

  factory AlphaEvolutionDetailsEvolutionChain.fromJson(String source) =>
      AlphaEvolutionDetailsEvolutionChain.fromMap(json.decode(source));

  final int? minLevel;
  final AlphaTriggerEvolutionChain? trigger;

  Map<String, dynamic> toMap() {
    return {'min_level': minLevel, 'trigger': trigger?.toMap()};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [minLevel, trigger];
}

class AlphaTriggerEvolutionChain extends Equatable {
  const AlphaTriggerEvolutionChain({this.name});

  factory AlphaTriggerEvolutionChain.fromMap(Map<String, dynamic> map) {
    return AlphaTriggerEvolutionChain(name: map['name']);
  }

  factory AlphaTriggerEvolutionChain.fromJson(String source) =>
      AlphaTriggerEvolutionChain.fromMap(json.decode(source));

  final String? name;

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [name];
}

class SpeciesEvolutionChain extends Equatable {
  const SpeciesEvolutionChain({this.name, this.url});

  factory SpeciesEvolutionChain.fromMap(Map<String, dynamic> map) {
    return SpeciesEvolutionChain(name: map['name'], url: map['url']);
  }

  factory SpeciesEvolutionChain.fromJson(String source) =>
      SpeciesEvolutionChain.fromMap(json.decode(source));

  final String? name;
  final String? url;

  Map<String, dynamic> toMap() {
    return {'name': name, 'url': url};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [name, url];
}

class AlphaSpeciesEvolutionChain extends Equatable {
  const AlphaSpeciesEvolutionChain({this.name, this.url});

  factory AlphaSpeciesEvolutionChain.fromMap(Map<String, dynamic> map) {
    return AlphaSpeciesEvolutionChain(name: map['name'], url: map['url']);
  }

  factory AlphaSpeciesEvolutionChain.fromJson(String source) =>
      AlphaSpeciesEvolutionChain.fromMap(json.decode(source));

  final String? name;
  final String? url;

  Map<String, dynamic> toMap() {
    return {'name': name, 'url': url};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [name, url];
}

class BetaSpeciesEvolutionChain extends Equatable {
  const BetaSpeciesEvolutionChain({this.name, this.url});

  factory BetaSpeciesEvolutionChain.fromMap(Map<String, dynamic> map) {
    return BetaSpeciesEvolutionChain(name: map['name'], url: map['url']);
  }

  factory BetaSpeciesEvolutionChain.fromJson(String source) =>
      BetaSpeciesEvolutionChain.fromMap(json.decode(source));

  final String? name;
  final String? url;

  Map<String, dynamic> toMap() {
    return {'name': name, 'url': url};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [name, url];
}
