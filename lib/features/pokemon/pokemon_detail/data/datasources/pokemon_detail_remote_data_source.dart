import 'package:morpheme_http/morpheme_http.dart';
import 'package:poketter/core/endpoints/morpheme_endpoints.dart';

import '../models/body/pokemon_detail_body.dart';
import '../models/response/pokemon_detail_response.dart';

abstract class PokemonDetailRemoteDataSource {
  Future<PokemonDetailResponse> pokemonDetail(
    PokemonDetailBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  });
}

class PokemonDetailRemoteDataSourceImpl
    implements PokemonDetailRemoteDataSource {
  PokemonDetailRemoteDataSourceImpl({required this.http});

  final MorphemeHttp http;

  @override
  Future<PokemonDetailResponse> pokemonDetail(
    PokemonDetailBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    final response = await http.get(
      MorphemeEndpoints.pokemonDetail(body.id),
      body: body.toMap(),
      headers: headers,
      cacheStrategy: cacheStrategy ?? AsyncOrCacheStrategy(),
    );
    return PokemonDetailResponse.fromJson(response.body);
  }
}
