import 'package:equatable/equatable.dart';

class PokemonDetailEntity extends Equatable {
  const PokemonDetailEntity({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.sprites,
    this.stats,
    this.types,
  });

  factory PokemonDetailEntity.dummy() => PokemonDetailEntity(
    id: 1,
    name: 'bulbasaur',
    height: 7,
    weight: 69,
    sprites: SpritesPokemonDetail.dummy(),
    stats: [StatsPokemonDetail.dummy()],
    types: [TypesPokemonDetail.dummy()],
  );

  final int? id;
  final String? name;
  final int? height;
  final int? weight;
  final SpritesPokemonDetail? sprites;
  final List<StatsPokemonDetail>? stats;
  final List<TypesPokemonDetail>? types;

  PokemonDetailEntity copyWith({
    int? id,
    String? name,
    int? height,
    int? weight,
    SpritesPokemonDetail? sprites,
    List<StatsPokemonDetail>? stats,
    List<TypesPokemonDetail>? types,
  }) {
    return PokemonDetailEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      sprites: sprites ?? this.sprites,
      stats: stats ?? this.stats,
      types: types ?? this.types,
    );
  }

  @override
  List<Object?> get props => [id, name, height, weight, sprites, stats, types];
}

class SpritesPokemonDetail extends Equatable {
  const SpritesPokemonDetail({this.other});

  factory SpritesPokemonDetail.dummy() =>
      SpritesPokemonDetail(other: OtherPokemonDetail.dummy());

  final OtherPokemonDetail? other;

  SpritesPokemonDetail copyWith({OtherPokemonDetail? other}) {
    return SpritesPokemonDetail(other: other ?? this.other);
  }

  @override
  List<Object?> get props => [other];
}

class OtherPokemonDetail extends Equatable {
  const OtherPokemonDetail({this.officialArtwork});

  factory OtherPokemonDetail.dummy() =>
      OtherPokemonDetail(officialArtwork: OfficialArtworkPokemonDetail.dummy());

  final OfficialArtworkPokemonDetail? officialArtwork;

  OtherPokemonDetail copyWith({OfficialArtworkPokemonDetail? officialArtwork}) {
    return OtherPokemonDetail(
      officialArtwork: officialArtwork ?? this.officialArtwork,
    );
  }

  @override
  List<Object?> get props => [officialArtwork];
}

class OfficialArtworkPokemonDetail extends Equatable {
  const OfficialArtworkPokemonDetail({this.frontDefault});

  factory OfficialArtworkPokemonDetail.dummy() => OfficialArtworkPokemonDetail(
    frontDefault:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
  );

  final String? frontDefault;

  OfficialArtworkPokemonDetail copyWith({String? frontDefault}) {
    return OfficialArtworkPokemonDetail(
      frontDefault: frontDefault ?? this.frontDefault,
    );
  }

  @override
  List<Object?> get props => [frontDefault];
}

class StatsPokemonDetail extends Equatable {
  const StatsPokemonDetail({this.baseStat, this.stat});

  factory StatsPokemonDetail.dummy() =>
      StatsPokemonDetail(baseStat: 45, stat: StatPokemonDetail.dummy());

  final int? baseStat;
  final StatPokemonDetail? stat;

  StatsPokemonDetail copyWith({int? baseStat, StatPokemonDetail? stat}) {
    return StatsPokemonDetail(
      baseStat: baseStat ?? this.baseStat,
      stat: stat ?? this.stat,
    );
  }

  @override
  List<Object?> get props => [baseStat, stat];
}

class StatPokemonDetail extends Equatable {
  const StatPokemonDetail({this.name});

  factory StatPokemonDetail.dummy() => StatPokemonDetail(name: 'hp');

  final String? name;

  StatPokemonDetail copyWith({String? name}) {
    return StatPokemonDetail(name: name ?? this.name);
  }

  @override
  List<Object?> get props => [name];
}

class TypesPokemonDetail extends Equatable {
  const TypesPokemonDetail({this.slot, this.type});

  factory TypesPokemonDetail.dummy() =>
      TypesPokemonDetail(slot: 1, type: TypePokemonDetail.dummy());

  final int? slot;
  final TypePokemonDetail? type;

  TypesPokemonDetail copyWith({int? slot, TypePokemonDetail? type}) {
    return TypesPokemonDetail(slot: slot ?? this.slot, type: type ?? this.type);
  }

  @override
  List<Object?> get props => [slot, type];
}

class TypePokemonDetail extends Equatable {
  const TypePokemonDetail({this.name});

  factory TypePokemonDetail.dummy() => TypePokemonDetail(name: 'grass');

  final String? name;

  TypePokemonDetail copyWith({String? name}) {
    return TypePokemonDetail(name: name ?? this.name);
  }

  @override
  List<Object?> get props => [name];
}
