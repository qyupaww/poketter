// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'dart:io';
import 'package:poketter/features/pokemon/pokemon_detail/mapper.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/pokemon_detail_response.dart'
    as response_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_detail_entity.dart'
    as entity_pokemon_detail;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

String readJsonFile(String filePath) => File(filePath).readAsStringSync();

Future<void> main() async {
  initializeDateFormatting();

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
  final Map<String, dynamic> map = {
    "id": 1,
    "name": "bulbasaur",
    "height": 7,
    "weight": 69,
    "sprites": {
      "other": {
        "official-artwork": {
          "front_default":
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
        },
      },
    },
    "stats": [
      {
        "base_stat": 45,
        "stat": {"name": "hp"},
      },
    ],
    "types": [
      {
        "slot": 1,
        "type": {"name": "grass"},
      },
    ],
  };

  test('mapper response model to PokemonDetailEntity entity', () async {
    expect(
      responsePokemonDetail.toEntity(),
      isA<entity_pokemon_detail.PokemonDetailEntity>(),
    );
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is real data', () async {
      // arrange
      final json = readJsonFile(
        'test/features/pokemon/pokemon_detail_test/json/pokemon_detail_success.json',
      );
      // act
      final result = response_pokemon_detail.PokemonDetailResponse.fromJson(
        json,
      );
      // assert
      expect(result, responsePokemonDetail);
    });
  });

  group('fromMap', () {
    test(
      'should return a valid model when the Map is an map of response model',
      () async {
        // act
        final result = response_pokemon_detail.PokemonDetailResponse.fromMap(
          map,
        );
        // assert
        expect(result, responsePokemonDetail);
      },
    );
  });

  group('toMap', () {
    test('should return a map containing the proper model', () async {
      // act
      final result = responsePokemonDetail.toMap();
      // assert
      expect(result, map);
    });
  });

  group('toJson', () {
    test('should return a JSON String containing the proper model', () async {
      // act
      final result = responsePokemonDetail.toJson();
      // assert
      expect(result, isA<String>());
    });
  });
}
