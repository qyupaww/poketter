// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_detail_body.dart'
    as body_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_detail_entity.dart'
    as entity_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/domain/usecases/pokemon_detail_use_case.dart';
import 'package:poketter/features/pokemon/pokemon_detail/presentation/bloc/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morpheme_http/morpheme_http.dart';

class MockUseCase extends Mock implements PokemonDetailUseCase {}

Future<void> main() async {
  late PokemonDetailBloc bloc;
  late MockUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockUseCase();
    bloc = PokemonDetailBloc(useCase: mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be Initial', () {
    expect(bloc.state, equals(PokemonDetailInitial()));
  });

  group('PokemonDetail Bloc', () {
    const bodyPokemonDetail = body_pokemon_detail.PokemonDetailBody(id: 'id');

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

    blocTest<PokemonDetailBloc, PokemonDetailState>(
      'should get data from the subject use case',
      setUp: () {
        when(() => mockUseCase(bodyPokemonDetail)).thenAnswer(
          (_) async => Right(entity_pokemon_detail.PokemonDetailEntity()),
        );
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonDetail);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonDetail(bodyPokemonDetail)),
    );

    blocTest<PokemonDetailBloc, PokemonDetailState>(
      'should emit [Loading, Success] when data is gotten successfully',
      setUp: () {
        when(() => mockUseCase(bodyPokemonDetail)).thenAnswer(
          (_) async => Right(entity_pokemon_detail.PokemonDetailEntity()),
        );
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonDetail);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonDetail(bodyPokemonDetail)),
      expect: () => [
        PokemonDetailLoading(bodyPokemonDetail, null, null),
        PokemonDetailSuccess(
          bodyPokemonDetail,
          null,
          entity_pokemon_detail.PokemonDetailEntity(),
          null,
        ),
      ],
    );

    blocTest<PokemonDetailBloc, PokemonDetailState>(
      'should emit [Loading, Failed] when getting timeout failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonDetail),
        ).thenAnswer((_) async => Left(timeoutFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonDetail);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonDetail(bodyPokemonDetail)),
      expect: () => [
        PokemonDetailLoading(bodyPokemonDetail, null, null),
        PokemonDetailFailed(bodyPokemonDetail, null, timeoutFailed, null),
      ],
    );

    blocTest<PokemonDetailBloc, PokemonDetailState>(
      'should emit [Loading, Failed] when getting unauthorized failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonDetail),
        ).thenAnswer((_) async => Left(unauthorizedFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonDetail);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonDetail(bodyPokemonDetail)),
      expect: () => [
        PokemonDetailLoading(bodyPokemonDetail, null, null),
        PokemonDetailFailed(bodyPokemonDetail, null, unauthorizedFailed, null),
      ],
    );

    blocTest<PokemonDetailBloc, PokemonDetailState>(
      'should emit [Loading, Failed] when getting internal failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonDetail),
        ).thenAnswer((_) async => Left(internalFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonDetail);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonDetail(bodyPokemonDetail)),
      expect: () => [
        PokemonDetailLoading(bodyPokemonDetail, null, null),
        PokemonDetailFailed(bodyPokemonDetail, null, internalFailed, null),
      ],
    );

    blocTest<PokemonDetailBloc, PokemonDetailState>(
      'should emit [Loading, Failed] when getting redirection failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonDetail),
        ).thenAnswer((_) async => Left(redirectionFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonDetail);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonDetail(bodyPokemonDetail)),
      expect: () => [
        PokemonDetailLoading(bodyPokemonDetail, null, null),
        PokemonDetailFailed(bodyPokemonDetail, null, redirectionFailed, null),
      ],
    );

    blocTest<PokemonDetailBloc, PokemonDetailState>(
      'should emit [Loading, Failed] when getting client failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonDetail),
        ).thenAnswer((_) async => Left(clientFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonDetail);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonDetail(bodyPokemonDetail)),
      expect: () => [
        PokemonDetailLoading(bodyPokemonDetail, null, null),
        PokemonDetailFailed(bodyPokemonDetail, null, clientFailed, null),
      ],
    );

    blocTest<PokemonDetailBloc, PokemonDetailState>(
      'should emit [Loading, Failed] when getting server failed',
      setUp: () {
        when(
          () => mockUseCase(bodyPokemonDetail),
        ).thenAnswer((_) async => Left(serverFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyPokemonDetail);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchPokemonDetail(bodyPokemonDetail)),
      expect: () => [
        PokemonDetailLoading(bodyPokemonDetail, null, null),
        PokemonDetailFailed(bodyPokemonDetail, null, serverFailed, null),
      ],
    );
  });
}
