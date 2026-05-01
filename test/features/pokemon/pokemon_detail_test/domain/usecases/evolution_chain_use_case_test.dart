// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:poketter/features/pokemon/pokemon_detail/domain/repositories/pokemon_detail_repository.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/evolution_chain_body.dart'
    as body_evolution_chain;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/evolution_chain_entity.dart'
    as entity_evolution_chain;
import 'package:poketter/features/pokemon/pokemon_detail/domain/usecases/evolution_chain_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morpheme_http/morpheme_http.dart';

class MockRepository extends Mock implements PokemonDetailRepository {}

Future<void> main() async {
  late EvolutionChainUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = EvolutionChainUseCase(repository: mockRepository);
  });

  const bodyEvolutionChain = body_evolution_chain.EvolutionChainBody(id: 'id');

  test('Should fetch entity for the body from the repository', () async {
    // arrange
    when(() => mockRepository.evolutionChain(bodyEvolutionChain)).thenAnswer(
      (_) async => Right(entity_evolution_chain.EvolutionChainEntity()),
    );
    // act
    final result = await usecase(bodyEvolutionChain);
    // assert
    expect(
      result,
      isA<
        Right<MorphemeFailure, entity_evolution_chain.EvolutionChainEntity>
      >(),
    );
    verify(() => mockRepository.evolutionChain(bodyEvolutionChain));
    verifyNoMoreInteractions(mockRepository);
  });
}
