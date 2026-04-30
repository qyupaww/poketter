import 'dart:convert';

import 'package:equatable/equatable.dart';

class PokemonDetailResponse extends Equatable {
  const PokemonDetailResponse({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.sprites,
    this.stats,
    this.types,
  });

  factory PokemonDetailResponse.fromMap(Map<String, dynamic> map) {
    return PokemonDetailResponse(
      id: int.tryParse(map['id']?.toString() ?? ''),
      name: map['name'],
      height: int.tryParse(map['height']?.toString() ?? ''),
      weight: int.tryParse(map['weight']?.toString() ?? ''),
      sprites: map['sprites'] == null
          ? null
          : SpritesPokemonDetail.fromMap(map['sprites']),
      stats: map['stats'] is List
          ? List.from(
              (map['stats'] as List)
                  .where((element) => element != null)
                  .map((e) => StatsPokemonDetail.fromMap(e)),
            )
          : null,
      types: map['types'] is List
          ? List.from(
              (map['types'] as List)
                  .where((element) => element != null)
                  .map((e) => TypesPokemonDetail.fromMap(e)),
            )
          : null,
    );
  }

  factory PokemonDetailResponse.fromJson(String source) =>
      PokemonDetailResponse.fromMap(json.decode(source));

  final int? id;
  final String? name;
  final int? height;
  final int? weight;
  final SpritesPokemonDetail? sprites;
  final List<StatsPokemonDetail>? stats;
  final List<TypesPokemonDetail>? types;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'sprites': sprites?.toMap(),
      'stats': stats?.map((e) => e.toMap()).toList(),
      'types': types?.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [id, name, height, weight, sprites, stats, types];
}

class SpritesPokemonDetail extends Equatable {
  const SpritesPokemonDetail({this.other});

  factory SpritesPokemonDetail.fromMap(Map<String, dynamic> map) {
    return SpritesPokemonDetail(
      other: map['other'] == null
          ? null
          : OtherPokemonDetail.fromMap(map['other']),
    );
  }

  factory SpritesPokemonDetail.fromJson(String source) =>
      SpritesPokemonDetail.fromMap(json.decode(source));

  final OtherPokemonDetail? other;

  Map<String, dynamic> toMap() {
    return {'other': other?.toMap()};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [other];
}

class OtherPokemonDetail extends Equatable {
  const OtherPokemonDetail({this.officialArtwork});

  factory OtherPokemonDetail.fromMap(Map<String, dynamic> map) {
    return OtherPokemonDetail(
      officialArtwork: map['official-artwork'] == null
          ? null
          : OfficialArtworkPokemonDetail.fromMap(map['official-artwork']),
    );
  }

  factory OtherPokemonDetail.fromJson(String source) =>
      OtherPokemonDetail.fromMap(json.decode(source));

  final OfficialArtworkPokemonDetail? officialArtwork;

  Map<String, dynamic> toMap() {
    return {'official-artwork': officialArtwork?.toMap()};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [officialArtwork];
}

class OfficialArtworkPokemonDetail extends Equatable {
  const OfficialArtworkPokemonDetail({this.frontDefault});

  factory OfficialArtworkPokemonDetail.fromMap(Map<String, dynamic> map) {
    return OfficialArtworkPokemonDetail(frontDefault: map['front_default']);
  }

  factory OfficialArtworkPokemonDetail.fromJson(String source) =>
      OfficialArtworkPokemonDetail.fromMap(json.decode(source));

  final String? frontDefault;

  Map<String, dynamic> toMap() {
    return {'front_default': frontDefault};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [frontDefault];
}

class StatsPokemonDetail extends Equatable {
  const StatsPokemonDetail({this.baseStat, this.stat});

  factory StatsPokemonDetail.fromMap(Map<String, dynamic> map) {
    return StatsPokemonDetail(
      baseStat: int.tryParse(map['base_stat']?.toString() ?? ''),
      stat: map['stat'] == null ? null : StatPokemonDetail.fromMap(map['stat']),
    );
  }

  factory StatsPokemonDetail.fromJson(String source) =>
      StatsPokemonDetail.fromMap(json.decode(source));

  final int? baseStat;
  final StatPokemonDetail? stat;

  Map<String, dynamic> toMap() {
    return {'base_stat': baseStat, 'stat': stat?.toMap()};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [baseStat, stat];
}

class StatPokemonDetail extends Equatable {
  const StatPokemonDetail({this.name});

  factory StatPokemonDetail.fromMap(Map<String, dynamic> map) {
    return StatPokemonDetail(name: map['name']);
  }

  factory StatPokemonDetail.fromJson(String source) =>
      StatPokemonDetail.fromMap(json.decode(source));

  final String? name;

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [name];
}

class TypesPokemonDetail extends Equatable {
  const TypesPokemonDetail({this.slot, this.type});

  factory TypesPokemonDetail.fromMap(Map<String, dynamic> map) {
    return TypesPokemonDetail(
      slot: int.tryParse(map['slot']?.toString() ?? ''),
      type: map['type'] == null ? null : TypePokemonDetail.fromMap(map['type']),
    );
  }

  factory TypesPokemonDetail.fromJson(String source) =>
      TypesPokemonDetail.fromMap(json.decode(source));

  final int? slot;
  final TypePokemonDetail? type;

  Map<String, dynamic> toMap() {
    return {'slot': slot, 'type': type?.toMap()};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [slot, type];
}

class TypePokemonDetail extends Equatable {
  const TypePokemonDetail({this.name});

  factory TypePokemonDetail.fromMap(Map<String, dynamic> map) {
    return TypePokemonDetail(name: map['name']);
  }

  factory TypePokemonDetail.fromJson(String source) =>
      TypePokemonDetail.fromMap(json.decode(source));

  final String? name;

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [name];
}
