// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'dart:convert';

import 'package:poketter/features/pokemon/pokemon_detail/data/datasources/pokemon_detail_remote_data_source.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_detail_body.dart'
    as body_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/pokemon_detail_response.dart'
    as response_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_species_body.dart'
    as body_pokemon_species;
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/pokemon_species_response.dart'
    as response_pokemon_species;
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/evolution_chain_body.dart'
    as body_evolution_chain;
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/evolution_chain_response.dart'
    as response_evolution_chain;
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
  final urlPokemonSpecies = MorphemeEndpoints.pokemonSpecies('id');
  const bodyPokemonSpecies = body_pokemon_species.PokemonSpeciesBody(id: 'id');
  final urlEvolutionChain = MorphemeEndpoints.evolutionChain('id');
  const bodyEvolutionChain = body_evolution_chain.EvolutionChainBody(id: 'id');

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

  group('PokemonSpecies Api Remote Data Source', () {
    test('should peform fetch & return response', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonSpecies,
          body: bodyPokemonSpecies.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenAnswer((_) async => Response('{}', 200));
      // act
      final result = await remoteDataSource.pokemonSpecies(bodyPokemonSpecies);
      // assert
      verify(
        () => http.get(
          urlPokemonSpecies,
          body: bodyPokemonSpecies.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      );
      expect(result, isA<response_pokemon_species.PokemonSpeciesResponse>());
    });

    test('should throw a RedirectionException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonSpecies,
          body: bodyPokemonSpecies.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(RedirectionException(statusCode: 300, jsonBody: '{}'));
      // act
      final call = remoteDataSource.pokemonSpecies;
      // assert
      expect(
        () => call(bodyPokemonSpecies),
        throwsA(isA<RedirectionException>()),
      );
    });

    test('should throw a ClientException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonSpecies,
          body: bodyPokemonSpecies.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(ClientException(statusCode: 400, jsonBody: '{}'));
      // act
      final call = remoteDataSource.pokemonSpecies;
      // assert
      expect(() => call(bodyPokemonSpecies), throwsA(isA<ClientException>()));
    });

    test('should throw a ServerException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonSpecies,
          body: bodyPokemonSpecies.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(ServerException(statusCode: 500, jsonBody: '{}'));
      // act
      final call = remoteDataSource.pokemonSpecies;
      // assert
      expect(() => call(bodyPokemonSpecies), throwsA(isA<ServerException>()));
    });

    test('should throw a TimeoutException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonSpecies,
          body: bodyPokemonSpecies.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(TimeoutException());
      // act
      final call = remoteDataSource.pokemonSpecies;
      // assert
      expect(() => call(bodyPokemonSpecies), throwsA(isA<TimeoutException>()));
    });

    test(
      'should throw a UnauthorizedException when the server error',
      () async {
        // arrange
        when(
          () => http.get(
            urlPokemonSpecies,
            body: bodyPokemonSpecies.toMap(),
            cacheStrategy: AsyncOrCacheStrategy(),
          ),
        ).thenThrow(UnauthorizedException(statusCode: 401, jsonBody: '{}'));
        // act
        final call = remoteDataSource.pokemonSpecies;
        // assert
        expect(
          () => call(bodyPokemonSpecies),
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
            urlPokemonSpecies,
            body: bodyPokemonSpecies.toMap(),
            cacheStrategy: AsyncOrCacheStrategy(),
          ),
        ).thenThrow(RefreshTokenException(statusCode: 401, jsonBody: '{}'));
        // act
        final call = remoteDataSource.pokemonSpecies;
        // assert
        expect(
          () => call(bodyPokemonSpecies),
          throwsA(isA<RefreshTokenException>()),
        );
      },
    );

    test('should throw a NoInternetException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlPokemonSpecies,
          body: bodyPokemonSpecies.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(NoInternetException());
      // act
      final call = remoteDataSource.pokemonSpecies;
      // assert
      expect(
        () => call(bodyPokemonSpecies),
        throwsA(isA<NoInternetException>()),
      );
    });
  });

  group('EvolutionChain Api Remote Data Source', () {
    test('should peform fetch & return response', () async {
      // arrange
      when(
        () => http.get(
          urlEvolutionChain,
          body: bodyEvolutionChain.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenAnswer((_) async => Response('{}', 200));
      // act
      final result = await remoteDataSource.evolutionChain(bodyEvolutionChain);
      // assert
      verify(
        () => http.get(
          urlEvolutionChain,
          body: bodyEvolutionChain.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      );
      expect(result, isA<response_evolution_chain.EvolutionChainResponse>());
    });

    test('should throw a RedirectionException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlEvolutionChain,
          body: bodyEvolutionChain.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(RedirectionException(statusCode: 300, jsonBody: '{}'));
      // act
      final call = remoteDataSource.evolutionChain;
      // assert
      expect(
        () => call(bodyEvolutionChain),
        throwsA(isA<RedirectionException>()),
      );
    });

    test('should throw a ClientException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlEvolutionChain,
          body: bodyEvolutionChain.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(ClientException(statusCode: 400, jsonBody: '{}'));
      // act
      final call = remoteDataSource.evolutionChain;
      // assert
      expect(() => call(bodyEvolutionChain), throwsA(isA<ClientException>()));
    });

    test('should throw a ServerException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlEvolutionChain,
          body: bodyEvolutionChain.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(ServerException(statusCode: 500, jsonBody: '{}'));
      // act
      final call = remoteDataSource.evolutionChain;
      // assert
      expect(() => call(bodyEvolutionChain), throwsA(isA<ServerException>()));
    });

    test('should throw a TimeoutException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlEvolutionChain,
          body: bodyEvolutionChain.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(TimeoutException());
      // act
      final call = remoteDataSource.evolutionChain;
      // assert
      expect(() => call(bodyEvolutionChain), throwsA(isA<TimeoutException>()));
    });

    test(
      'should throw a UnauthorizedException when the server error',
      () async {
        // arrange
        when(
          () => http.get(
            urlEvolutionChain,
            body: bodyEvolutionChain.toMap(),
            cacheStrategy: AsyncOrCacheStrategy(),
          ),
        ).thenThrow(UnauthorizedException(statusCode: 401, jsonBody: '{}'));
        // act
        final call = remoteDataSource.evolutionChain;
        // assert
        expect(
          () => call(bodyEvolutionChain),
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
            urlEvolutionChain,
            body: bodyEvolutionChain.toMap(),
            cacheStrategy: AsyncOrCacheStrategy(),
          ),
        ).thenThrow(RefreshTokenException(statusCode: 401, jsonBody: '{}'));
        // act
        final call = remoteDataSource.evolutionChain;
        // assert
        expect(
          () => call(bodyEvolutionChain),
          throwsA(isA<RefreshTokenException>()),
        );
      },
    );

    test('should throw a NoInternetException when the server error', () async {
      // arrange
      when(
        () => http.get(
          urlEvolutionChain,
          body: bodyEvolutionChain.toMap(),
          cacheStrategy: AsyncOrCacheStrategy(),
        ),
      ).thenThrow(NoInternetException());
      // act
      final call = remoteDataSource.evolutionChain;
      // assert
      expect(
        () => call(bodyEvolutionChain),
        throwsA(isA<NoInternetException>()),
      );
    });
  });
}
