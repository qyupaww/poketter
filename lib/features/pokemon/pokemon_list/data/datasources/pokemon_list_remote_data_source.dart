import 'package:morpheme_http/morpheme_http.dart';
import 'package:poketter/core/endpoints/morpheme_endpoints.dart';

import '../models/body/pokemon_list_body.dart';
import '../models/response/pokemon_list_response.dart';

abstract class PokemonListRemoteDataSource {
  Future<PokemonListResponse> pokemonList(
    PokemonListBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  });
}

class PokemonListRemoteDataSourceImpl implements PokemonListRemoteDataSource {
  PokemonListRemoteDataSourceImpl({required this.http});

  final MorphemeHttp http;

  @override
  Future<PokemonListResponse> pokemonList(
    PokemonListBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    // Use pokemonAll with high limit to fetch all Pokemon across all generations
    final response = await http.get(
      MorphemeEndpoints.pokemonAll(limit: 10000, offset: 0),
      body: body.toMap(),
      headers: headers,
      cacheStrategy: cacheStrategy ?? AsyncOrCacheStrategy(),
    );
    return PokemonListResponse.fromJson(response.body);
  }
}
