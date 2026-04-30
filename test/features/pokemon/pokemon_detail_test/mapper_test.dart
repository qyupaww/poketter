// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:poketter/features/pokemon/pokemon_detail/mapper.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/pokemon_detail_response.dart'
    as response_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_detail_entity.dart'
    as entity_pokemon_detail;
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  test('mapper response model to entity PokemonDetail', () {
    const responsePokemonDetail = response_pokemon_detail.PokemonDetailResponse(
      id: 1,
      name: 'bulbasaur',
      height: 7,
      weight: 69,
      sprites: response_pokemon_detail.SpritesPokemonDetail(
        other: response_pokemon_detail.OtherPokemonDetail(
          officialArtwork: response_pokemon_detail.OfficialArtworkPokemonDetail(
            frontDefault:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
          ),
        ),
      ),
      stats: [
        response_pokemon_detail.StatsPokemonDetail(
          stat: response_pokemon_detail.StatPokemonDetail(name: 'hp'),
          baseStat: 45,
        ),
      ],
      types: [
        response_pokemon_detail.TypesPokemonDetail(
          type: response_pokemon_detail.TypePokemonDetail(name: 'grass'),
          slot: 1,
        ),
      ],
    );
    const entityPokemonDetail = entity_pokemon_detail.PokemonDetailEntity(
      id: 1,
      name: 'bulbasaur',
      height: 7,
      weight: 69,
      sprites: entity_pokemon_detail.SpritesPokemonDetail(
        other: entity_pokemon_detail.OtherPokemonDetail(
          officialArtwork: entity_pokemon_detail.OfficialArtworkPokemonDetail(
            frontDefault:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
          ),
        ),
      ),
      stats: [
        entity_pokemon_detail.StatsPokemonDetail(
          stat: entity_pokemon_detail.StatPokemonDetail(name: 'hp'),
          baseStat: 45,
        ),
      ],
      types: [
        entity_pokemon_detail.TypesPokemonDetail(
          type: entity_pokemon_detail.TypePokemonDetail(name: 'grass'),
          slot: 1,
        ),
      ],
    );

    expect(responsePokemonDetail.toEntity(), entityPokemonDetail);
  });

  test('mapper entity to response model PokemonDetail', () {
    const responsePokemonDetail = response_pokemon_detail.PokemonDetailResponse(
      id: 1,
      name: 'bulbasaur',
      height: 7,
      weight: 69,
      sprites: response_pokemon_detail.SpritesPokemonDetail(
        other: response_pokemon_detail.OtherPokemonDetail(
          officialArtwork: response_pokemon_detail.OfficialArtworkPokemonDetail(
            frontDefault:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
          ),
        ),
      ),
      stats: [
        response_pokemon_detail.StatsPokemonDetail(
          stat: response_pokemon_detail.StatPokemonDetail(name: 'hp'),
          baseStat: 45,
        ),
      ],
      types: [
        response_pokemon_detail.TypesPokemonDetail(
          type: response_pokemon_detail.TypePokemonDetail(name: 'grass'),
          slot: 1,
        ),
      ],
    );
    const entityPokemonDetail = entity_pokemon_detail.PokemonDetailEntity(
      id: 1,
      name: 'bulbasaur',
      height: 7,
      weight: 69,
      sprites: entity_pokemon_detail.SpritesPokemonDetail(
        other: entity_pokemon_detail.OtherPokemonDetail(
          officialArtwork: entity_pokemon_detail.OfficialArtworkPokemonDetail(
            frontDefault:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
          ),
        ),
      ),
      stats: [
        entity_pokemon_detail.StatsPokemonDetail(
          stat: entity_pokemon_detail.StatPokemonDetail(name: 'hp'),
          baseStat: 45,
        ),
      ],
      types: [
        entity_pokemon_detail.TypesPokemonDetail(
          type: entity_pokemon_detail.TypePokemonDetail(name: 'grass'),
          slot: 1,
        ),
      ],
    );

    expect(entityPokemonDetail.toResponse(), responsePokemonDetail);
  });
}
