// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'dart:io';
import 'package:poketter/features/pokemon/pokemon_detail/mapper.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/pokemon_species_response.dart'
    as response_pokemon_species;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_species_entity.dart'
    as entity_pokemon_species;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

String readJsonFile(String filePath) => File(filePath).readAsStringSync();

Future<void> main() async {
  initializeDateFormatting();

  const responsePokemonSpecies =
      response_pokemon_species.PokemonSpeciesResponse(
        eggGroups: [
          response_pokemon_species.EggGroupsPokemonSpecies(
            name: 'monster',
            url: 'https://pokeapi.co/api/v2/egg-group/1/',
          ),
          response_pokemon_species.EggGroupsPokemonSpecies(
            name: 'plant',
            url: 'https://pokeapi.co/api/v2/egg-group/7/',
          ),
        ],
        hatchCounter: 20,
        evolutionChain: response_pokemon_species.EvolutionChainPokemonSpecies(
          url: 'https://pokeapi.co/api/v2/evolution-chain/1/',
        ),
      );
  final Map<String, dynamic> map = {
    "egg_groups": [
      {"name": "monster", "url": "https://pokeapi.co/api/v2/egg-group/1/"},
      {"name": "plant", "url": "https://pokeapi.co/api/v2/egg-group/7/"},
    ],
    "hatch_counter": 20,
    "evolution_chain": {"url": "https://pokeapi.co/api/v2/evolution-chain/1/"},
  };

  test('mapper response model to PokemonSpeciesEntity entity', () async {
    expect(
      responsePokemonSpecies.toEntity(),
      isA<entity_pokemon_species.PokemonSpeciesEntity>(),
    );
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is real data', () async {
      // arrange
      final json = readJsonFile(
        'test/features/pokemon/pokemon_detail_test/json/pokemon_species_success.json',
      );
      // act
      final result = response_pokemon_species.PokemonSpeciesResponse.fromJson(
        json,
      );
      // assert
      expect(result, responsePokemonSpecies);
    });
  });

  group('fromMap', () {
    test(
      'should return a valid model when the Map is an map of response model',
      () async {
        // act
        final result = response_pokemon_species.PokemonSpeciesResponse.fromMap(
          map,
        );
        // assert
        expect(result, responsePokemonSpecies);
      },
    );
  });

  group('toMap', () {
    test('should return a map containing the proper model', () async {
      // act
      final result = responsePokemonSpecies.toMap();
      // assert
      expect(result, map);
    });
  });

  group('toJson', () {
    test('should return a JSON String containing the proper model', () async {
      // act
      final result = responsePokemonSpecies.toJson();
      // assert
      expect(result, isA<String>());
    });
  });
}
