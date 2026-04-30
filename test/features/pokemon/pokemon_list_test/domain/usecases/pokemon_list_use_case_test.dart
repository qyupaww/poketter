// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:poketter/features/pokemon/pokemon_list/domain/repositories/pokemon_list_repository.dart';
import 'package:poketter/features/pokemon/pokemon_list/data/models/body/pokemon_list_body.dart'
    as body_pokemon_list;
import 'package:poketter/features/pokemon/pokemon_list/domain/entities/pokemon_list_entity.dart'
    as entity_pokemon_list;
import 'package:poketter/features/pokemon/pokemon_list/domain/usecases/pokemon_list_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morpheme_http/morpheme_http.dart';

class MockRepository extends Mock implements PokemonListRepository {}

Future<void> main() async {
  late PokemonListUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = PokemonListUseCase(repository: mockRepository);
  });

  const bodyPokemonList = body_pokemon_list.PokemonListBody();

  test('Should fetch entity for the body from the repository', () async {
    // arrange
    when(
      () => mockRepository.pokemonList(bodyPokemonList),
    ).thenAnswer((_) async => Right(entity_pokemon_list.PokemonListEntity()));
    // act
    final result = await usecase(bodyPokemonList);
    // assert
    expect(
      result,
      isA<Right<MorphemeFailure, entity_pokemon_list.PokemonListEntity>>(),
    );
    verify(() => mockRepository.pokemonList(bodyPokemonList));
    verifyNoMoreInteractions(mockRepository);
  });
}
