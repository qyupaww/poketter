// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/evolution_chain_body.dart'
    as body_evolution_chain;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/evolution_chain_entity.dart'
    as entity_evolution_chain;
import 'package:poketter/features/pokemon/pokemon_detail/domain/usecases/evolution_chain_use_case.dart';
import 'package:poketter/features/pokemon/pokemon_detail/presentation/bloc/evolution_chain/evolution_chain_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morpheme_http/morpheme_http.dart';

class MockUseCase extends Mock implements EvolutionChainUseCase {}

Future<void> main() async {
  late EvolutionChainBloc bloc;
  late MockUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockUseCase();
    bloc = EvolutionChainBloc(useCase: mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be Initial', () {
    expect(bloc.state, equals(EvolutionChainInitial()));
  });

  group('EvolutionChain Bloc', () {
    const bodyEvolutionChain = body_evolution_chain.EvolutionChainBody(
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

    blocTest<EvolutionChainBloc, EvolutionChainState>(
      'should get data from the subject use case',
      setUp: () {
        when(() => mockUseCase(bodyEvolutionChain)).thenAnswer(
          (_) async => Right(entity_evolution_chain.EvolutionChainEntity()),
        );
      },
      verify: (bloc) {
        mockUseCase(bodyEvolutionChain);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchEvolutionChain(bodyEvolutionChain)),
    );

    blocTest<EvolutionChainBloc, EvolutionChainState>(
      'should emit [Loading, Success] when data is gotten successfully',
      setUp: () {
        when(() => mockUseCase(bodyEvolutionChain)).thenAnswer(
          (_) async => Right(entity_evolution_chain.EvolutionChainEntity()),
        );
      },
      verify: (bloc) {
        mockUseCase(bodyEvolutionChain);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchEvolutionChain(bodyEvolutionChain)),
      expect: () => [
        EvolutionChainLoading(bodyEvolutionChain, null, null),
        EvolutionChainSuccess(
          bodyEvolutionChain,
          null,
          entity_evolution_chain.EvolutionChainEntity(),
          null,
        ),
      ],
    );

    blocTest<EvolutionChainBloc, EvolutionChainState>(
      'should emit [Loading, Failed] when getting timeout failed',
      setUp: () {
        when(
          () => mockUseCase(bodyEvolutionChain),
        ).thenAnswer((_) async => Left(timeoutFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyEvolutionChain);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchEvolutionChain(bodyEvolutionChain)),
      expect: () => [
        EvolutionChainLoading(bodyEvolutionChain, null, null),
        EvolutionChainFailed(bodyEvolutionChain, null, timeoutFailed, null),
      ],
    );

    blocTest<EvolutionChainBloc, EvolutionChainState>(
      'should emit [Loading, Failed] when getting unauthorized failed',
      setUp: () {
        when(
          () => mockUseCase(bodyEvolutionChain),
        ).thenAnswer((_) async => Left(unauthorizedFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyEvolutionChain);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchEvolutionChain(bodyEvolutionChain)),
      expect: () => [
        EvolutionChainLoading(bodyEvolutionChain, null, null),
        EvolutionChainFailed(
          bodyEvolutionChain,
          null,
          unauthorizedFailed,
          null,
        ),
      ],
    );

    blocTest<EvolutionChainBloc, EvolutionChainState>(
      'should emit [Loading, Failed] when getting internal failed',
      setUp: () {
        when(
          () => mockUseCase(bodyEvolutionChain),
        ).thenAnswer((_) async => Left(internalFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyEvolutionChain);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchEvolutionChain(bodyEvolutionChain)),
      expect: () => [
        EvolutionChainLoading(bodyEvolutionChain, null, null),
        EvolutionChainFailed(bodyEvolutionChain, null, internalFailed, null),
      ],
    );

    blocTest<EvolutionChainBloc, EvolutionChainState>(
      'should emit [Loading, Failed] when getting redirection failed',
      setUp: () {
        when(
          () => mockUseCase(bodyEvolutionChain),
        ).thenAnswer((_) async => Left(redirectionFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyEvolutionChain);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchEvolutionChain(bodyEvolutionChain)),
      expect: () => [
        EvolutionChainLoading(bodyEvolutionChain, null, null),
        EvolutionChainFailed(bodyEvolutionChain, null, redirectionFailed, null),
      ],
    );

    blocTest<EvolutionChainBloc, EvolutionChainState>(
      'should emit [Loading, Failed] when getting client failed',
      setUp: () {
        when(
          () => mockUseCase(bodyEvolutionChain),
        ).thenAnswer((_) async => Left(clientFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyEvolutionChain);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchEvolutionChain(bodyEvolutionChain)),
      expect: () => [
        EvolutionChainLoading(bodyEvolutionChain, null, null),
        EvolutionChainFailed(bodyEvolutionChain, null, clientFailed, null),
      ],
    );

    blocTest<EvolutionChainBloc, EvolutionChainState>(
      'should emit [Loading, Failed] when getting server failed',
      setUp: () {
        when(
          () => mockUseCase(bodyEvolutionChain),
        ).thenAnswer((_) async => Left(serverFailed));
      },
      verify: (bloc) {
        mockUseCase(bodyEvolutionChain);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchEvolutionChain(bodyEvolutionChain)),
      expect: () => [
        EvolutionChainLoading(bodyEvolutionChain, null, null),
        EvolutionChainFailed(bodyEvolutionChain, null, serverFailed, null),
      ],
    );
  });
}
