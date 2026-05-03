// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'dart:io';
import 'package:poketter/features/pokemon/pokemon_detail/mapper.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/evolution_chain_response.dart'
    as response_evolution_chain;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/evolution_chain_entity.dart'
    as entity_evolution_chain;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

String readJsonFile(String filePath) => File(filePath).readAsStringSync();

Future<void> main() async {
  initializeDateFormatting();

  const responseEvolutionChain = response_evolution_chain.EvolutionChainResponse(
    chain: response_evolution_chain.ChainEvolutionChain(
      species: response_evolution_chain.SpeciesEvolutionChain(
        name: 'bulbasaur',
        url: 'https://pokeapi.co/api/v2/pokemon-species/1/',
      ),
      evolutionDetails: [],
      evolvesTo: [
        response_evolution_chain.EvolvesToEvolutionChain(
          species: response_evolution_chain.SpeciesEvolutionChain(
            name: 'ivysaur',
            url: 'https://pokeapi.co/api/v2/pokemon-species/2/',
          ),
          evolutionDetails: [
            response_evolution_chain.EvolutionDetailsEvolutionChain(
              trigger: response_evolution_chain.TriggerEvolutionChain(
                name: 'level-up',
              ),
              minLevel: 16,
            ),
          ],
          evolvesTo: [
            response_evolution_chain.AlphaEvolvesToEvolutionChain(
              species: response_evolution_chain.SpeciesEvolutionChain(
                name: 'venusaur',
                url: 'https://pokeapi.co/api/v2/pokemon-species/3/',
              ),
              evolutionDetails: [
                response_evolution_chain.AlphaEvolutionDetailsEvolutionChain(
                  trigger: response_evolution_chain.AlphaTriggerEvolutionChain(
                    name: 'level-up',
                  ),
                  minLevel: 32,
                ),
              ],
              evolvesTo: [],
            ),
          ],
        ),
      ],
    ),
  );
  final Map<String, dynamic> map = {
    "chain": {
      "evolution_details": [],
      "evolves_to": [
        {
          "evolution_details": [
            {
              "min_level": 16,
              "trigger": {"name": "level-up"},
            },
          ],
          "evolves_to": [
            {
              "evolution_details": [
                {
                  "min_level": 32,
                  "trigger": {"name": "level-up"},
                },
              ],
              "evolves_to": [],
              "species": {
                "name": "venusaur",
                "url": "https://pokeapi.co/api/v2/pokemon-species/3/",
              },
            },
          ],
          "species": {
            "name": "ivysaur",
            "url": "https://pokeapi.co/api/v2/pokemon-species/2/",
          },
        },
      ],
      "species": {
        "name": "bulbasaur",
        "url": "https://pokeapi.co/api/v2/pokemon-species/1/",
      },
    },
  };

  test('mapper response model to EvolutionChainEntity entity', () async {
    expect(
      responseEvolutionChain.toEntity(),
      isA<entity_evolution_chain.EvolutionChainEntity>(),
    );
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is real data', () async {
      // arrange
      final json = readJsonFile(
        'test/features/pokemon/pokemon_detail_test/json/evolution_chain_success.json',
      );
      // act
      final result = response_evolution_chain.EvolutionChainResponse.fromJson(
        json,
      );
      // assert
      expect(result, responseEvolutionChain);
    });
  });

  group('fromMap', () {
    test(
      'should return a valid model when the Map is an map of response model',
      () async {
        // act
        final result = response_evolution_chain.EvolutionChainResponse.fromMap(
          map,
        );
        // assert
        expect(result, responseEvolutionChain);
      },
    );
  });

  group('toMap', () {
    test('should return a map containing the proper model', () async {
      // act
      final result = responseEvolutionChain.toMap();
      // assert
      expect(result, map);
    });
  });

  group('toJson', () {
    test('should return a JSON String containing the proper model', () async {
      // act
      final result = responseEvolutionChain.toJson();
      // assert
      expect(result, isA<String>());
    });
  });
}
