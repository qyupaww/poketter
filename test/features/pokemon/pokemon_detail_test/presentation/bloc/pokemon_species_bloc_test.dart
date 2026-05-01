// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_species_body.dart'
    as body_pokemon_species;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_species_entity.dart'
    as entity_pokemon_species;
import 'package:poketter/features/pokemon/pokemon_detail/domain/usecases/pokemon_species_use_case.dart';
import 'package:poketter/features/pokemon/pokemon_detail/presentation/bloc/pokemon_species/pokemon_species_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morpheme_http/morpheme_http.dart';

class MockUseCase extends Mock implements PokemonSpeciesUseCase {}

Future<void> main() async {
  late PokemonSpeciesBloc bloc;
  late MockUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockUseCase();
    bloc = PokemonSpeciesBloc(useCase: mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be Initial', () {
    expect(bloc.state, equals(PokemonSpeciesInitial()));
  });

  group('PokemonSpecies Bloc', () {
    const bodyPokemonSpecies = body_pokemon_species.PokemonSpeciesBody(
      id: 'id',
    );

    const timeoutFailed = TimeoutFailure('TimoutFailure');
    const internalFailed = InternalFailure('InternalFailure');

    const redirectionFailed = RedirectionFailure(
      'RedirectionFailure',
      statusCode: 300,
      jsonBody: '{}',
    );

    const clientFailed = ClientFailure(
      'ClientFailure',
      statusCode: 400,
      jsonBody: '{}',
    );

    const serverFailed = ServerFailure(
      'ServerFailure',
      statusCode: 500,
      jsonBody: '{}',
    );

    const unauthorizedFailed = UnauthorizedFailure(
      'UnauthorizedFailure',
      statusCode: 401,
      jsonBody: '{}',
    );

    blocTest<PokemonSpeciesBloc, PokemonSpeciesState>(
      'should get data from the subject use case',
      setUp: () {
        when(() => mockUseCase(bodyPokemonSpecies)).thenAnswer(
          (_) async => Right(entity_pokemon_species.PokemonSpeciesEntity()),
        );
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonSpecies);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonSpecies(bodyPokemonSpecies)),
    );

    blocTest<PokemonSpeciesBloc, PokemonSpeciesState>(
      'should emit [Loading, Success] when data is gotten successfully',
      setUp: () {
        when(() => mockUseCase(bodyPokemonSpecies)).thenAnswer(
          (_) async => Right(entity_pokemon_species.PokemonSpeciesEntity()),
        );
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonSpecies);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonSpecies(bodyPokemonSpecies)),
      expect: () => [
        PokemonSpeciesLoading(bodyPokemonSpecies, null, null),
        PokemonSpeciesSuccess(
          bodyPokemonSpecies,
          null,
          entity_pokemon_species.PokemonSpeciesEntity(),
          null,
        ),
      ],
    );

    blocTest<PokemonSpeciesBloc, PokemonSpeciesState>(
      'should emit [Loading, Failed] when getting timeout failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonSpecies),
        ).thenAnswer((_) async => Left(timeoutFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonSpecies);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonSpecies(bodyPokemonSpecies)),
      expect: () => [
        PokemonSpeciesLoading(bodyPokemonSpecies, null, null),
        PokemonSpeciesFailed(bodyPokemonSpecies, null, timeoutFailed, null),
      ],
    );

    blocTest<PokemonSpeciesBloc, PokemonSpeciesState>(
      'should emit [Loading, Failed] when getting unauthorized failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonSpecies),
        ).thenAnswer((_) async => Left(unauthorizedFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonSpecies);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonSpecies(bodyPokemonSpecies)),
      expect: () => [
        PokemonSpeciesLoading(bodyPokemonSpecies, null, null),
        PokemonSpeciesFailed(
          bodyPokemonSpecies,
          null,
          unauthorizedFailed,
          null,
        ),
      ],
    );

    blocTest<PokemonSpeciesBloc, PokemonSpeciesState>(
      'should emit [Loading, Failed] when getting internal failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonSpecies),
        ).thenAnswer((_) async => Left(internalFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonSpecies);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonSpecies(bodyPokemonSpecies)),
      expect: () => [
        PokemonSpeciesLoading(bodyPokemonSpecies, null, null),
        PokemonSpeciesFailed(bodyPokemonSpecies, null, internalFailed, null),
      ],
    );

    blocTest<PokemonSpeciesBloc, PokemonSpeciesState>(
      'should emit [Loading, Failed] when getting redirection failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonSpecies),
        ).thenAnswer((_) async => Left(redirectionFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonSpecies);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonSpecies(bodyPokemonSpecies)),
      expect: () => [
        PokemonSpeciesLoading(bodyPokemonSpecies, null, null),
        PokemonSpeciesFailed(bodyPokemonSpecies, null, redirectionFailed, null),
      ],
    );

    blocTest<PokemonSpeciesBloc, PokemonSpeciesState>(
      'should emit [Loading, Failed] when getting client failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonSpecies),
        ).thenAnswer((_) async => Left(clientFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonSpecies);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonSpecies(bodyPokemonSpecies)),
      expect: () => [
        PokemonSpeciesLoading(bodyPokemonSpecies, null, null),
        PokemonSpeciesFailed(bodyPokemonSpecies, null, clientFailed, null),
      ],
    );

    blocTest<PokemonSpeciesBloc, PokemonSpeciesState>(
      'should emit [Loading, Failed] when getting server failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonSpecies),
        ).thenAnswer((_) async => Left(serverFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonSpecies);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonSpecies(bodyPokemonSpecies)),
      expect: () => [
        PokemonSpeciesLoading(bodyPokemonSpecies, null, null),
        PokemonSpeciesFailed(bodyPokemonSpecies, null, serverFailed, null),
      ],
    );
  });
}
