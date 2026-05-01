// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:poketter/features/pokemon/pokemon_detail/data/datasources/pokemon_detail_remote_data_source.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/repositories/pokemon_detail_repository_impl.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_detail_body.dart'
    as body_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/pokemon_detail_response.dart'
    as response_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_detail_entity.dart'
    as entity_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_species_body.dart'
    as body_pokemon_species;
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/pokemon_species_response.dart'
    as response_pokemon_species;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_species_entity.dart'
    as entity_pokemon_species;
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/evolution_chain_body.dart'
    as body_evolution_chain;
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/evolution_chain_response.dart'
    as response_evolution_chain;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/evolution_chain_entity.dart'
    as entity_evolution_chain;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morpheme_http/morpheme_http.dart';

class MockRemoteDataSource extends Mock
    implements PokemonDetailRemoteDataSource {}

Future<void> main() async {
  late MockRemoteDataSource mockRemoteDatasource;
  late PokemonDetailRepositoryImpl repository;

  setUp(() {
    mockRemoteDatasource = MockRemoteDataSource();
    repository = PokemonDetailRepositoryImpl(
      remoteDataSource: mockRemoteDatasource,
    );
  });

  group('PokemonDetail Api Repository', () {
    const bodyPokemonDetail = body_pokemon_detail.PokemonDetailBody(id: 'id');

    test(
      'should return response data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          () => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail),
        ).thenAnswer(
          (_) async => response_pokemon_detail.PokemonDetailResponse(),
        );
        // act
        final result = await repository.pokemonDetail(bodyPokemonDetail);
        // assert
        verify(() => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail));
        expect(
          result,
          isA<
            Right<MorphemeFailure, entity_pokemon_detail.PokemonDetailEntity>
          >(),
        );
      },
    );

    test(
      'should return redirection exception when the call to remote data source is unsuccessful',
      () async {
        final exception = RedirectionException(statusCode: 300, jsonBody: '{}');
        final failure = RedirectionFailure(
          exception.toString(),
          statusCode: 300,
          jsonBody: '{}',
        );
        // arrange
        when(
          () => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonDetail(bodyPokemonDetail);
        // assert
        verify(() => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return client failure when the call to remote data source is unsuccessful',
      () async {
        final exception = ClientException(statusCode: 400, jsonBody: '{}');
        final failure = ClientFailure(
          exception.toString(),
          statusCode: 400,
          jsonBody: '{}',
        );
        // arrange
        when(
          () => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonDetail(bodyPokemonDetail);
        // assert
        verify(() => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        final exception = ServerException(statusCode: 500, jsonBody: '{}');
        final failure = ServerFailure(
          exception.toString(),
          statusCode: 500,
          jsonBody: '{}',
        );
        // arrange
        when(
          () => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonDetail(bodyPokemonDetail);
        // assert
        verify(() => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return unauthorized failure when the call to remote data source is unsuccessful',
      () async {
        final exception = UnauthorizedException(
          statusCode: 401,
          jsonBody: '{}',
        );
        final failure = UnauthorizedFailure(
          exception.toString(),
          statusCode: 401,
          jsonBody: '{}',
        );
        // arrange
        when(
          () => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonDetail(bodyPokemonDetail);
        // assert
        verify(() => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return timeout failure when the call to remote data source is unsuccessful',
      () async {
        final exception = TimeoutException();
        final failure = TimeoutFailure(exception.toString());
        // arrange
        when(
          () => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonDetail(bodyPokemonDetail);
        // assert
        verify(() => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return internal failure when the call to remote data source is unsuccessful',
      () async {
        final exception = InternalException();
        final failure = InternalFailure(exception.toString());
        // arrange
        when(
          () => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonDetail(bodyPokemonDetail);
        // assert
        verify(() => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return no internet failure when the call to remote data source is unsuccessful',
      () async {
        final exception = NoInternetException();
        final failure = NoInternetFailure(exception.toString());
        // arrange
        when(
          () => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonDetail(bodyPokemonDetail);
        // assert
        verify(() => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return internal failure when the call to remote data source is unknown exception',
      () async {
        final exception = Exception('unknown');
        final failure = InternalFailure(exception.toString());
        // arrange
        when(
          () => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonDetail(bodyPokemonDetail);
        // assert
        verify(() => mockRemoteDatasource.pokemonDetail(bodyPokemonDetail));
        expect(result, equals(Left(failure)));
      },
    );
  });

  group('PokemonSpecies Api Repository', () {
    const bodyPokemonSpecies = body_pokemon_species.PokemonSpeciesBody(
      id: 'id',
    );

    test(
      'should return response data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          () => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies),
        ).thenAnswer(
          (_) async => response_pokemon_species.PokemonSpeciesResponse(),
        );
        // act
        final result = await repository.pokemonSpecies(bodyPokemonSpecies);
        // assert
        verify(() => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies));
        expect(
          result,
          isA<
            Right<MorphemeFailure, entity_pokemon_species.PokemonSpeciesEntity>
          >(),
        );
      },
    );

    test(
      'should return redirection exception when the call to remote data source is unsuccessful',
      () async {
        final exception = RedirectionException(statusCode: 300, jsonBody: '{}');
        final failure = RedirectionFailure(
          exception.toString(),
          statusCode: 300,
          jsonBody: '{}',
        );
        // arrange
        when(
          () => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonSpecies(bodyPokemonSpecies);
        // assert
        verify(() => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return client failure when the call to remote data source is unsuccessful',
      () async {
        final exception = ClientException(statusCode: 400, jsonBody: '{}');
        final failure = ClientFailure(
          exception.toString(),
          statusCode: 400,
          jsonBody: '{}',
        );
        // arrange
        when(
          () => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonSpecies(bodyPokemonSpecies);
        // assert
        verify(() => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        final exception = ServerException(statusCode: 500, jsonBody: '{}');
        final failure = ServerFailure(
          exception.toString(),
          statusCode: 500,
          jsonBody: '{}',
        );
        // arrange
        when(
          () => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonSpecies(bodyPokemonSpecies);
        // assert
        verify(() => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return unauthorized failure when the call to remote data source is unsuccessful',
      () async {
        final exception = UnauthorizedException(
          statusCode: 401,
          jsonBody: '{}',
        );
        final failure = UnauthorizedFailure(
          exception.toString(),
          statusCode: 401,
          jsonBody: '{}',
        );
        // arrange
        when(
          () => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonSpecies(bodyPokemonSpecies);
        // assert
        verify(() => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return timeout failure when the call to remote data source is unsuccessful',
      () async {
        final exception = TimeoutException();
        final failure = TimeoutFailure(exception.toString());
        // arrange
        when(
          () => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonSpecies(bodyPokemonSpecies);
        // assert
        verify(() => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return internal failure when the call to remote data source is unsuccessful',
      () async {
        final exception = InternalException();
        final failure = InternalFailure(exception.toString());
        // arrange
        when(
          () => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonSpecies(bodyPokemonSpecies);
        // assert
        verify(() => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return no internet failure when the call to remote data source is unsuccessful',
      () async {
        final exception = NoInternetException();
        final failure = NoInternetFailure(exception.toString());
        // arrange
        when(
          () => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonSpecies(bodyPokemonSpecies);
        // assert
        verify(() => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return internal failure when the call to remote data source is unknown exception',
      () async {
        final exception = Exception('unknown');
        final failure = InternalFailure(exception.toString());
        // arrange
        when(
          () => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonSpecies(bodyPokemonSpecies);
        // assert
        verify(() => mockRemoteDatasource.pokemonSpecies(bodyPokemonSpecies));
        expect(result, equals(Left(failure)));
      },
    );
  });

  group('EvolutionChain Api Repository', () {
    const bodyEvolutionChain = body_evolution_chain.EvolutionChainBody(
      id: 'id',
    );

    test(
      'should return response data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          () => mockRemoteDatasource.evolutionChain(bodyEvolutionChain),
        ).thenAnswer(
          (_) async => response_evolution_chain.EvolutionChainResponse(),
        );
        // act
        final result = await repository.evolutionChain(bodyEvolutionChain);
        // assert
        verify(() => mockRemoteDatasource.evolutionChain(bodyEvolutionChain));
        expect(
          result,
          isA<
            Right<MorphemeFailure, entity_evolution_chain.EvolutionChainEntity>
          >(),
        );
      },
    );

    test(
      'should return redirection exception when the call to remote data source is unsuccessful',
      () async {
        final exception = RedirectionException(statusCode: 300, jsonBody: '{}');
        final failure = RedirectionFailure(
          exception.toString(),
          statusCode: 300,
          jsonBody: '{}',
        );
        // arrange
        when(
          () => mockRemoteDatasource.evolutionChain(bodyEvolutionChain),
        ).thenThrow(exception);
        // act
        final result = await repository.evolutionChain(bodyEvolutionChain);
        // assert
        verify(() => mockRemoteDatasource.evolutionChain(bodyEvolutionChain));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return client failure when the call to remote data source is unsuccessful',
      () async {
        final exception = ClientException(statusCode: 400, jsonBody: '{}');
        final failure = ClientFailure(
          exception.toString(),
          statusCode: 400,
          jsonBody: '{}',
        );
        // arrange
        when(
          () => mockRemoteDatasource.evolutionChain(bodyEvolutionChain),
        ).thenThrow(exception);
        // act
        final result = await repository.evolutionChain(bodyEvolutionChain);
        // assert
        verify(() => mockRemoteDatasource.evolutionChain(bodyEvolutionChain));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        final exception = ServerException(statusCode: 500, jsonBody: '{}');
        final failure = ServerFailure(
          exception.toString(),
          statusCode: 500,
          jsonBody: '{}',
        );
        // arrange
        when(
          () => mockRemoteDatasource.evolutionChain(bodyEvolutionChain),
        ).thenThrow(exception);
        // act
        final result = await repository.evolutionChain(bodyEvolutionChain);
        // assert
        verify(() => mockRemoteDatasource.evolutionChain(bodyEvolutionChain));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return unauthorized failure when the call to remote data source is unsuccessful',
      () async {
        final exception = UnauthorizedException(
          statusCode: 401,
          jsonBody: '{}',
        );
        final failure = UnauthorizedFailure(
          exception.toString(),
          statusCode: 401,
          jsonBody: '{}',
        );
        // arrange
        when(
          () => mockRemoteDatasource.evolutionChain(bodyEvolutionChain),
        ).thenThrow(exception);
        // act
        final result = await repository.evolutionChain(bodyEvolutionChain);
        // assert
        verify(() => mockRemoteDatasource.evolutionChain(bodyEvolutionChain));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return timeout failure when the call to remote data source is unsuccessful',
      () async {
        final exception = TimeoutException();
        final failure = TimeoutFailure(exception.toString());
        // arrange
        when(
          () => mockRemoteDatasource.evolutionChain(bodyEvolutionChain),
        ).thenThrow(exception);
        // act
        final result = await repository.evolutionChain(bodyEvolutionChain);
        // assert
        verify(() => mockRemoteDatasource.evolutionChain(bodyEvolutionChain));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return internal failure when the call to remote data source is unsuccessful',
      () async {
        final exception = InternalException();
        final failure = InternalFailure(exception.toString());
        // arrange
        when(
          () => mockRemoteDatasource.evolutionChain(bodyEvolutionChain),
        ).thenThrow(exception);
        // act
        final result = await repository.evolutionChain(bodyEvolutionChain);
        // assert
        verify(() => mockRemoteDatasource.evolutionChain(bodyEvolutionChain));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return no internet failure when the call to remote data source is unsuccessful',
      () async {
        final exception = NoInternetException();
        final failure = NoInternetFailure(exception.toString());
        // arrange
        when(
          () => mockRemoteDatasource.evolutionChain(bodyEvolutionChain),
        ).thenThrow(exception);
        // act
        final result = await repository.evolutionChain(bodyEvolutionChain);
        // assert
        verify(() => mockRemoteDatasource.evolutionChain(bodyEvolutionChain));
        expect(result, equals(Left(failure)));
      },
    );

    test(
      'should return internal failure when the call to remote data source is unknown exception',
      () async {
        final exception = Exception('unknown');
        final failure = InternalFailure(exception.toString());
        // arrange
        when(
          () => mockRemoteDatasource.evolutionChain(bodyEvolutionChain),
        ).thenThrow(exception);
        // act
        final result = await repository.evolutionChain(bodyEvolutionChain);
        // assert
        verify(() => mockRemoteDatasource.evolutionChain(bodyEvolutionChain));
        expect(result, equals(Left(failure)));
      },
    );
  });
}
