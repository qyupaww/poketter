// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:poketter/features/pokemon/pokemon_detail/domain/repositories/pokemon_detail_repository.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_detail_body.dart'
    as body_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_detail_entity.dart'
    as entity_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/domain/usecases/pokemon_detail_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morpheme_http/morpheme_http.dart';

class MockRepository extends Mock implements PokemonDetailRepository {}

Future<void> main() async {
  late PokemonDetailUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = PokemonDetailUseCase(repository: mockRepository);
  });

  const bodyPokemonDetail = body_pokemon_detail.PokemonDetailBody(id: 'id');

  test('Should fetch entity for the body from the repository', () async {
    // arrange
    when(() => mockRepository.pokemonDetail(bodyPokemonDetail)).thenAnswer(
      (_) async => Right(entity_pokemon_detail.PokemonDetailEntity()),
    );
    // act
    final result = await usecase(bodyPokemonDetail);
    // assert
    expect(
      result,
      isA<Right<MorphemeFailure, entity_pokemon_detail.PokemonDetailEntity>>(),
    );
    verify(() => mockRepository.pokemonDetail(bodyPokemonDetail));
    verifyNoMoreInteractions(mockRepository);
  });
}
