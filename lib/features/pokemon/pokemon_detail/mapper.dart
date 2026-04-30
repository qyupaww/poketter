import 'data/models/response/pokemon_detail_response.dart'
    as pokemon_detail_response;
import 'domain/entities/pokemon_detail_entity.dart' as pokemon_detail_entity;

extension PokemonDetailResponseMapper
    on pokemon_detail_response.PokemonDetailResponse {
  pokemon_detail_entity.PokemonDetailEntity toEntity() =>
      pokemon_detail_entity.PokemonDetailEntity(
        id: id,
        name: name,
        height: height,
        weight: weight,
        sprites: sprites?.toEntity(),
        stats: stats?.map((e) => e.toEntity()).toList(),
        types: types?.map((e) => e.toEntity()).toList(),
      );
}

extension PokemonDetailEntityMapper
    on pokemon_detail_entity.PokemonDetailEntity {
  pokemon_detail_response.PokemonDetailResponse toResponse() =>
      pokemon_detail_response.PokemonDetailResponse(
        id: id,
        name: name,
        height: height,
        weight: weight,
        sprites: sprites?.toResponse(),
        stats: stats?.map((e) => e.toResponse()).toList(),
        types: types?.map((e) => e.toResponse()).toList(),
      );
}

extension SpritesPokemonDetailResponseMapper
    on pokemon_detail_response.SpritesPokemonDetail {
  pokemon_detail_entity.SpritesPokemonDetail toEntity() =>
      pokemon_detail_entity.SpritesPokemonDetail(other: other?.toEntity());
}

extension SpritesPokemonDetailEntityMapper
    on pokemon_detail_entity.SpritesPokemonDetail {
  pokemon_detail_response.SpritesPokemonDetail toResponse() =>
      pokemon_detail_response.SpritesPokemonDetail(other: other?.toResponse());
}

extension OtherPokemonDetailResponseMapper
    on pokemon_detail_response.OtherPokemonDetail {
  pokemon_detail_entity.OtherPokemonDetail toEntity() =>
      pokemon_detail_entity.OtherPokemonDetail(
        officialArtwork: officialArtwork?.toEntity(),
      );
}

extension OtherPokemonDetailEntityMapper
    on pokemon_detail_entity.OtherPokemonDetail {
  pokemon_detail_response.OtherPokemonDetail toResponse() =>
      pokemon_detail_response.OtherPokemonDetail(
        officialArtwork: officialArtwork?.toResponse(),
      );
}

extension OfficialArtworkPokemonDetailResponseMapper
    on pokemon_detail_response.OfficialArtworkPokemonDetail {
  pokemon_detail_entity.OfficialArtworkPokemonDetail toEntity() =>
      pokemon_detail_entity.OfficialArtworkPokemonDetail(
        frontDefault: frontDefault,
      );
}

extension OfficialArtworkPokemonDetailEntityMapper
    on pokemon_detail_entity.OfficialArtworkPokemonDetail {
  pokemon_detail_response.OfficialArtworkPokemonDetail toResponse() =>
      pokemon_detail_response.OfficialArtworkPokemonDetail(
        frontDefault: frontDefault,
      );
}

extension StatsPokemonDetailResponseMapper
    on pokemon_detail_response.StatsPokemonDetail {
  pokemon_detail_entity.StatsPokemonDetail toEntity() =>
      pokemon_detail_entity.StatsPokemonDetail(
        baseStat: baseStat,
        stat: stat?.toEntity(),
      );
}

extension StatsPokemonDetailEntityMapper
    on pokemon_detail_entity.StatsPokemonDetail {
  pokemon_detail_response.StatsPokemonDetail toResponse() =>
      pokemon_detail_response.StatsPokemonDetail(
        baseStat: baseStat,
        stat: stat?.toResponse(),
      );
}

extension StatPokemonDetailResponseMapper
    on pokemon_detail_response.StatPokemonDetail {
  pokemon_detail_entity.StatPokemonDetail toEntity() =>
      pokemon_detail_entity.StatPokemonDetail(name: name);
}

extension StatPokemonDetailEntityMapper
    on pokemon_detail_entity.StatPokemonDetail {
  pokemon_detail_response.StatPokemonDetail toResponse() =>
      pokemon_detail_response.StatPokemonDetail(name: name);
}

extension TypesPokemonDetailResponseMapper
    on pokemon_detail_response.TypesPokemonDetail {
  pokemon_detail_entity.TypesPokemonDetail toEntity() =>
      pokemon_detail_entity.TypesPokemonDetail(
        slot: slot,
        type: type?.toEntity(),
      );
}

extension TypesPokemonDetailEntityMapper
    on pokemon_detail_entity.TypesPokemonDetail {
  pokemon_detail_response.TypesPokemonDetail toResponse() =>
      pokemon_detail_response.TypesPokemonDetail(
        slot: slot,
        type: type?.toResponse(),
      );
}

extension TypePokemonDetailResponseMapper
    on pokemon_detail_response.TypePokemonDetail {
  pokemon_detail_entity.TypePokemonDetail toEntity() =>
      pokemon_detail_entity.TypePokemonDetail(name: name);
}

extension TypePokemonDetailEntityMapper
    on pokemon_detail_entity.TypePokemonDetail {
  pokemon_detail_response.TypePokemonDetail toResponse() =>
      pokemon_detail_response.TypePokemonDetail(name: name);
}
