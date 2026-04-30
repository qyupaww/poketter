// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'dart:convert';

import 'package:poketter/features/pokemon/pokemon_detail/data/datasources/pokemon_detail_remote_data_source.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_detail_body.dart'
    as body_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/pokemon_detail_response.dart'
    as response_pokemon_detail;
import 'package:poketter/core/endpoints/morpheme_endpoints.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morpheme_http/morpheme_http.dart';

class MockMorphemeHttp extends Mock implements MorphemeHttp {}

Future<void> main() async {
  initializeDateFormatting();

  late MockMorphemeHttp http;
  late PokemonDetailRemoteDataSource remoteDataSource;

  final urlPokemonDetail = MorphemeEndpoints.pokemonDetail('id');
  const bodyPokemonDetail = body_pokemon_detail.PokemonDetailBody(id: 'id');

  setUp(() {
    http = MockMorphemeHttp();
    remoteDataSource = PokemonDetailRemoteDataSourceImpl(http: http);
  });

  group('PokemonDetail Api Remote Data Source', () {
    test('should peform fetch & return response', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonDetail,
          body: bodyPokemonDetail.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenAnswer((_) async => Response('{}', 200));
      // act
      final result = await remoteDataSource.pokemonDetail(bodyPokemonDetail);
      // assert
      verify(
        () => http.get(
          urlPokemonDetail,
          body: bodyPokemonDetail.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      );
      expect(result, isA<response_pokemon_detail.PokemonDetailResponse>());
    });

    test('should throw a RedirectionException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonDetail,
          body: bodyPokemonDetail.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(RedirectionException(statusCode: 300, jsonBody: '{}'));
      // act
      final call = remoteDataSource.pokemonDetail;
      // assert
      expect(
        () => call(bodyPokemonDetail),
        throwsA(isA<RedirectionException>()),
      );
    });

    test('should throw a ClientException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonDetail,
          body: bodyPokemonDetail.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(ClientException(statusCode: 400, jsonBody: '{}'));
      // act
      final call = remoteDataSource.pokemonDetail;
      // assert
      expect(() => call(bodyPokemonDetail), throwsA(isA<ClientException>()));
    });

    test('should throw a ServerException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonDetail,
          body: bodyPokemonDetail.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(ServerException(statusCode: 500, jsonBody: '{}'));
      // act
      final call = remoteDataSource.pokemonDetail;
      // assert
      expect(() => call(bodyPokemonDetail), throwsA(isA<ServerException>()));
    });

    test('should throw a TimeoutException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonDetail,
          body: bodyPokemonDetail.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(TimeoutException());
      // act
      final call = remoteDataSource.pokemonDetail;
      // assert
      expect(() => call(bodyPokemonDetail), throwsA(isA<TimeoutException>()));
    });

    test(
      'should throw a UnauthorizedException when the server error',
      () async {
        // arrange
        when(
          () => http.get(
            urlPokemonDetail,
            body: bodyPokemonDetail.toMap(),
            cacheStrategy: AsyncOrCacheStrategy(),
          ),
        ).thenThrow(UnauthorizedException(statusCode: 401, jsonBody: '{}'));
        // act
        final call = remoteDataSource.pokemonDetail;
        // assert
        expect(
          () => call(bodyPokemonDetail),
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
            urlPokemonDetail,
            body: bodyPokemonDetail.toMap(),
            cacheStrategy: AsyncOrCacheStrategy(),
          ),
        ).thenThrow(RefreshTokenException(statusCode: 401, jsonBody: '{}'));
        // act
        final call = remoteDataSource.pokemonDetail;
        // assert
        expect(
          () => call(bodyPokemonDetail),
          throwsA(isA<RefreshTokenException>()),
        );
      },
    );

    test('should throw a NoInternetException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonDetail,
          body: bodyPokemonDetail.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(NoInternetException());
      // act
      final call = remoteDataSource.pokemonDetail;
      // assert
      expect(
        () => call(bodyPokemonDetail),
        throwsA(isA<NoInternetException>()),
      );
    });
  });
}
