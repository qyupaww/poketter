// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:poketter/features/pokemon/pokemon_list/mapper.dart';
import 'package:poketter/features/pokemon/pokemon_list/data/models/response/pokemon_list_response.dart'
    as response_pokemon_list;
import 'package:poketter/features/pokemon/pokemon_list/domain/entities/pokemon_list_entity.dart'
    as entity_pokemon_list;
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  test('mapper response model to entity PokemonList', () {
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
    const entityPokemonList = entity_pokemon_list.PokemonListEntity(
      count: 1302,
      next: 'https://pokeapi.co/api/v2/pokemon?offset=20&limit=20',
      previous: null,
      results: [
        entity_pokemon_list.ResultsPokemonList(
          name: 'bulbasaur',
          url: 'https://pokeapi.co/api/v2/pokemon/1/',
          imageUrl:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
        ),
      ],
    );

    expect(responsePokemonList.toEntity(), entityPokemonList);
  });

  test('mapper entity to response model PokemonList', () {
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
    const entityPokemonList = entity_pokemon_list.PokemonListEntity(
      count: 1302,
      next: 'https://pokeapi.co/api/v2/pokemon?offset=20&limit=20',
      previous: null,
      results: [
        entity_pokemon_list.ResultsPokemonList(
          name: 'bulbasaur',
          url: 'https://pokeapi.co/api/v2/pokemon/1/',
        ),
      ],
    );

    expect(entityPokemonList.toResponse(), responsePokemonList);
  });
}
