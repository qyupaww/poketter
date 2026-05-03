import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morpheme_http/morpheme_http.dart';
import 'package:poketter/features/pokemon/pokemon_list/domain/usecases/pokemon_filter_use_case.dart';
import 'package:poketter/features/pokemon/pokemon_list/presentation/cubit/pokemon_filter_cubit.dart';

class MockPokemonFilterUseCase extends Mock implements PokemonFilterUseCase {}

void main() {
  late MockPokemonFilterUseCase useCase;
  late PokemonFilterCubit cubit;

  setUp(() {
    useCase = MockPokemonFilterUseCase();
    cubit = PokemonFilterCubit(useCase: useCase);
  });

  tearDown(() async {
    await cubit.close();
  });

  test(
    'filterByType normalizes type URL values and maps Pokemon IDs',
    () async {
      when(() => useCase.type('15')).thenAnswer(
        (_) async => Right({
          'pokemon': [
            {
              'pokemon': {
                'name': 'dewgong',
                'url': 'https://pokeapi.co/api/v2/pokemon/87/',
              },
            },
          ],
        }),
      );

      final result = await cubit.filterByType(
        'https://pokeapi.co/api/v2/type/15/',
      );

      expect(result, hasLength(1));
      expect(result.single.name, 'dewgong');
      expect(result.single.id, '87');
      expect(result.single.imageUrl, contains('/87.png'));
      verify(() => useCase.type('15')).called(1);
    },
  );

  test(
    'filterByGenerationAndType intersects generation and type results',
    () async {
      when(() => useCase.generation('1')).thenAnswer(
        (_) async => Right({
          'pokemon_species': [
            {
              'name': 'dewgong',
              'url': 'https://pokeapi.co/api/v2/pokemon-species/87/',
            },
            {
              'name': 'pikachu',
              'url': 'https://pokeapi.co/api/v2/pokemon-species/25/',
            },
          ],
        }),
      );
      when(() => useCase.type('15')).thenAnswer(
        (_) async => Right({
          'pokemon': [
            {
              'pokemon': {
                'name': 'dewgong',
                'url': 'https://pokeapi.co/api/v2/pokemon/87/',
              },
            },
          ],
        }),
      );

      final result = await cubit.filterByGenerationAndType(
        'https://pokeapi.co/api/v2/generation/1/',
        'https://pokeapi.co/api/v2/type/15/',
      );

      expect(result.map((e) => e.name), ['dewgong']);
      expect(result.single.id, '87');
      verify(() => useCase.generation('1')).called(1);
      verify(() => useCase.type('15')).called(1);
    },
  );
}
