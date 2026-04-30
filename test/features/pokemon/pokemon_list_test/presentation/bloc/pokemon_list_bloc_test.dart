// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:poketter/features/pokemon/pokemon_list/data/models/body/pokemon_list_body.dart'
    as body_pokemon_list;
import 'package:poketter/features/pokemon/pokemon_list/domain/entities/pokemon_list_entity.dart'
    as entity_pokemon_list;
import 'package:poketter/features/pokemon/pokemon_list/domain/usecases/pokemon_list_use_case.dart';
import 'package:poketter/features/pokemon/pokemon_list/presentation/bloc/pokemon_list/pokemon_list_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morpheme_http/morpheme_http.dart';

class MockUseCase extends Mock implements PokemonListUseCase {}

Future<void> main() async {
  late PokemonListBloc bloc;
  late MockUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockUseCase();
    bloc = PokemonListBloc(useCase: mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be Initial', () {
    expect(bloc.state, equals(PokemonListInitial()));
  });

  group('PokemonList Bloc', () {
    const bodyPokemonList = body_pokemon_list.PokemonListBody();

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

    blocTest<PokemonListBloc, PokemonListState>(
      'should get data from the subject use case',
      setUp: () {
        when(() => mockUseCase(bodyPokemonList)).thenAnswer(
          (_) async => Right(entity_pokemon_list.PokemonListEntity()),
        );
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonList);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonList(bodyPokemonList)),
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [Loading, Success] when data is gotten successfully',
      setUp: () {
        when(() => mockUseCase(bodyPokemonList)).thenAnswer(
          (_) async => Right(entity_pokemon_list.PokemonListEntity()),
        );
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonList);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonList(bodyPokemonList)),
      expect: () => [
        PokemonListLoading(bodyPokemonList, null, null),
        PokemonListSuccess(
          bodyPokemonList,
          null,
          entity_pokemon_list.PokemonListEntity(),
          null,
        ),
      ],
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [Loading, Failed] when getting timeout failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonList),
        ).thenAnswer((_) async => Left(timeoutFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonList);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonList(bodyPokemonList)),
      expect: () => [
        PokemonListLoading(bodyPokemonList, null, null),
        PokemonListFailed(bodyPokemonList, null, timeoutFailed, null),
      ],
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [Loading, Failed] when getting unauthorized failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonList),
        ).thenAnswer((_) async => Left(unauthorizedFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonList);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonList(bodyPokemonList)),
      expect: () => [
        PokemonListLoading(bodyPokemonList, null, null),
        PokemonListFailed(bodyPokemonList, null, unauthorizedFailed, null),
      ],
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [Loading, Failed] when getting internal failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonList),
        ).thenAnswer((_) async => Left(internalFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonList);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonList(bodyPokemonList)),
      expect: () => [
        PokemonListLoading(bodyPokemonList, null, null),
        PokemonListFailed(bodyPokemonList, null, internalFailed, null),
      ],
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [Loading, Failed] when getting redirection failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonList),
        ).thenAnswer((_) async => Left(redirectionFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonList);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonList(bodyPokemonList)),
      expect: () => [
        PokemonListLoading(bodyPokemonList, null, null),
        PokemonListFailed(bodyPokemonList, null, redirectionFailed, null),
      ],
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [Loading, Failed] when getting client failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonList),
        ).thenAnswer((_) async => Left(clientFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonList);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonList(bodyPokemonList)),
      expect: () => [
        PokemonListLoading(bodyPokemonList, null, null),
        PokemonListFailed(bodyPokemonList, null, clientFailed, null),
      ],
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [Loading, Failed] when getting server failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonList),
        ).thenAnswer((_) async => Left(serverFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonList);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonList(bodyPokemonList)),
      expect: () => [
        PokemonListLoading(bodyPokemonList, null, null),
        PokemonListFailed(bodyPokemonList, null, serverFailed, null),
      ],
    );
  });
}
