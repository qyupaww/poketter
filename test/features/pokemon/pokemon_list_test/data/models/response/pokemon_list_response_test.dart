// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'dart:io';
import 'package:poketter/features/pokemon/pokemon_list/mapper.dart';
import 'package:poketter/features/pokemon/pokemon_list/data/models/response/pokemon_list_response.dart'
    as response_pokemon_list;
import 'package:poketter/features/pokemon/pokemon_list/domain/entities/pokemon_list_entity.dart'
    as entity_pokemon_list;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

String readJsonFile(String filePath) => File(filePath).readAsStringSync();

Future<void> main() async {
  initializeDateFormatting();

  const responsePokemonList = response_pokemon_list.PokemonListResponse(
    count: 1302,
    next: 'https://pokeapi.co/api/v2/pokemon?offset=20&limit=20',
    previous: null,
    results: [
      response_pokemon_list.ResultsPokemonList(
        name: 'bulbasaur',
        url: 'https://pokeapi.co/api/v2/pokemon/1/',
      ),
    ],
  );
  final Map<String, dynamic> map = {
    "count": 1302,
    "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
    "previous": null,
    "results": [
      {"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/"},
    ],
  };

  test('mapper response model to PokemonListEntity entity', () async {
    expect(
      responsePokemonList.toEntity(),
      isA<entity_pokemon_list.PokemonListEntity>(),
    );
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is real data', () async {
      // arrange
      final json = readJsonFile(
        'test/features/pokemon/pokemon_list_test/json/pokemon_list_success.json',
      );
      // act
      final result = response_pokemon_list.PokemonListResponse.fromJson(json);
      // assert
      expect(result, responsePokemonList);
    });
  });

  group('fromMap', () {
    test(
      'should return a valid model when the Map is an map of response model',
      () async {
        // act
        final result = response_pokemon_list.PokemonListResponse.fromMap(map);
        // assert
        expect(result, responsePokemonList);
      },
    );
  });

  group('toMap', () {
    test('should return a map containing the proper model', () async {
      // act
      final result = responsePokemonList.toMap();
      // assert
      expect(result, map);
    });
  });

  group('toJson', () {
    test('should return a JSON String containing the proper model', () async {
      // act
      final result = responsePokemonList.toJson();
      // assert
      expect(result, isA<String>());
    });
  });
}
