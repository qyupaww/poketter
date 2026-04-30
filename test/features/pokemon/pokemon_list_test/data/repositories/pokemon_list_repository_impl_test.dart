// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:poketter/features/pokemon/pokemon_list/data/datasources/pokemon_list_remote_data_source.dart';
import 'package:poketter/features/pokemon/pokemon_list/data/repositories/pokemon_list_repository_impl.dart';
import 'package:poketter/features/pokemon/pokemon_list/data/models/body/pokemon_list_body.dart'
    as body_pokemon_list;
import 'package:poketter/features/pokemon/pokemon_list/data/models/response/pokemon_list_response.dart'
    as response_pokemon_list;
import 'package:poketter/features/pokemon/pokemon_list/domain/entities/pokemon_list_entity.dart'
    as entity_pokemon_list;
import 'package:poketter/features/pokemon/pokemon_detail/data/datasources/pokemon_detail_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morpheme_http/morpheme_http.dart';

class MockRemoteDataSource extends Mock
    implements PokemonListRemoteDataSource {}

class MockDetailRemoteDataSource extends Mock
    implements PokemonDetailRemoteDataSource {}

Future<void> main() async {
  late MockRemoteDataSource mockRemoteDatasource;
  late MockDetailRemoteDataSource mockDetailRemoteDatasource;
  late PokemonListRepositoryImpl repository;

  setUp(() {
    mockRemoteDatasource = MockRemoteDataSource();
    mockDetailRemoteDatasource = MockDetailRemoteDataSource();
    repository = PokemonListRepositoryImpl(
      remoteDataSource: mockRemoteDatasource,
      detailRemoteDataSource: mockDetailRemoteDatasource,
    );
  });

  group('PokemonList Api Repository', () {
    const bodyPokemonList = body_pokemon_list.PokemonListBody();

    test(
      'should return response data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          () => mockRemoteDatasource.pokemonList(bodyPokemonList),
        ).thenAnswer((_) async => response_pokemon_list.PokemonListResponse());
        // act
        final result = await repository.pokemonList(bodyPokemonList);
        // assert
        verify(() => mockRemoteDatasource.pokemonList(bodyPokemonList));
        expect(
          result,
          isA<Right<MorphemeFailure, entity_pokemon_list.PokemonListEntity>>(),
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
          () => mockRemoteDatasource.pokemonList(bodyPokemonList),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonList(bodyPokemonList);
        // assert
        verify(() => mockRemoteDatasource.pokemonList(bodyPokemonList));
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
          () => mockRemoteDatasource.pokemonList(bodyPokemonList),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonList(bodyPokemonList);
        // assert
        verify(() => mockRemoteDatasource.pokemonList(bodyPokemonList));
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
          () => mockRemoteDatasource.pokemonList(bodyPokemonList),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonList(bodyPokemonList);
        // assert
        verify(() => mockRemoteDatasource.pokemonList(bodyPokemonList));
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
          () => mockRemoteDatasource.pokemonList(bodyPokemonList),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonList(bodyPokemonList);
        // assert
        verify(() => mockRemoteDatasource.pokemonList(bodyPokemonList));
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
          () => mockRemoteDatasource.pokemonList(bodyPokemonList),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonList(bodyPokemonList);
        // assert
        verify(() => mockRemoteDatasource.pokemonList(bodyPokemonList));
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
          () => mockRemoteDatasource.pokemonList(bodyPokemonList),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonList(bodyPokemonList);
        // assert
        verify(() => mockRemoteDatasource.pokemonList(bodyPokemonList));
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
          () => mockRemoteDatasource.pokemonList(bodyPokemonList),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonList(bodyPokemonList);
        // assert
        verify(() => mockRemoteDatasource.pokemonList(bodyPokemonList));
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
          () => mockRemoteDatasource.pokemonList(bodyPokemonList),
        ).thenThrow(exception);
        // act
        final result = await repository.pokemonList(bodyPokemonList);
        // assert
        verify(() => mockRemoteDatasource.pokemonList(bodyPokemonList));
        expect(result, equals(Left(failure)));
      },
    );
  });
}
