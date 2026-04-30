// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'dart:convert';

import 'package:poketter/features/pokemon/pokemon_list/data/datasources/pokemon_list_remote_data_source.dart';
import 'package:poketter/features/pokemon/pokemon_list/data/models/body/pokemon_list_body.dart'
    as body_pokemon_list;
import 'package:poketter/features/pokemon/pokemon_list/data/models/response/pokemon_list_response.dart'
    as response_pokemon_list;
import 'package:poketter/core/endpoints/morpheme_endpoints.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morpheme_http/morpheme_http.dart';

class MockMorphemeHttp extends Mock implements MorphemeHttp {}

Future<void> main() async {
  initializeDateFormatting();

  late MockMorphemeHttp http;
  late PokemonListRemoteDataSource remoteDataSource;

  final urlPokemonList = MorphemeEndpoints.pokemonList;
  const bodyPokemonList = body_pokemon_list.PokemonListBody();

  setUp(() {
    http = MockMorphemeHttp();
    remoteDataSource = PokemonListRemoteDataSourceImpl(http: http);
  });

  group('PokemonList Api Remote Data Source', () {
    test('should peform fetch & return response', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonList,
          body: bodyPokemonList.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenAnswer((_) async => Response('{}', 200));
      // act
      final result = await remoteDataSource.pokemonList(bodyPokemonList);
      // assert
      verify(
        () => http.get(
          urlPokemonList,
          body: bodyPokemonList.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      );
      expect(result, isA<response_pokemon_list.PokemonListResponse>());
    });

    test('should throw a RedirectionException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonList,
          body: bodyPokemonList.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(RedirectionException(statusCode: 300, jsonBody: '{}'));
      // act
      final call = remoteDataSource.pokemonList;
      // assert
      expect(() => call(bodyPokemonList), throwsA(isA<RedirectionException>()));
    });

    test('should throw a ClientException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonList,
          body: bodyPokemonList.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(ClientException(statusCode: 400, jsonBody: '{}'));
      // act
      final call = remoteDataSource.pokemonList;
      // assert
      expect(() => call(bodyPokemonList), throwsA(isA<ClientException>()));
    });

    test('should throw a ServerException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonList,
          body: bodyPokemonList.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(ServerException(statusCode: 500, jsonBody: '{}'));
      // act
      final call = remoteDataSource.pokemonList;
      // assert
      expect(() => call(bodyPokemonList), throwsA(isA<ServerException>()));
    });

    test('should throw a TimeoutException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonList,
          body: bodyPokemonList.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(TimeoutException());
      // act
      final call = remoteDataSource.pokemonList;
      // assert
      expect(() => call(bodyPokemonList), throwsA(isA<TimeoutException>()));
    });

    test(
      'should throw a UnauthorizedException when the server error',
      () async {
        // arrange
        when(
          () => http.get(
            urlPokemonList,
            body: bodyPokemonList.toMap(),
            cacheStrategy: AsyncOrCacheStrategy(),
          ),
        ).thenThrow(UnauthorizedException(statusCode: 401, jsonBody: '{}'));
        // act
        final call = remoteDataSource.pokemonList;
        // assert
        expect(
          () => call(bodyPokemonList),
          throwsA(isA<UnauthorizedException>()),
        );
      },
    );

    test(
      'should throw a RefreshTokenException when the server error',
      () async {
        // arrange
        when(
          () => http.get(
            urlPokemonList,
            body: bodyPokemonList.toMap(),
            cacheStrategy: AsyncOrCacheStrategy(),
          ),
        ).thenThrow(RefreshTokenException(statusCode: 401, jsonBody: '{}'));
        // act
        final call = remoteDataSource.pokemonList;
        // assert
        expect(
          () => call(bodyPokemonList),
          throwsA(isA<RefreshTokenException>()),
        );
      },
    );

    test('should throw a NoInternetException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonList,
          body: bodyPokemonList.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(NoInternetException());
      // act
      final call = remoteDataSource.pokemonList;
      // assert
      expect(() => call(bodyPokemonList), throwsA(isA<NoInternetException>()));
    });
  });
}
