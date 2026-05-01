import 'package:morpheme_http/morpheme_http.dart';

import '../models/body/evolution_chain_body.dart';
import '../models/response/evolution_chain_response.dart';
import '../models/body/pokemon_species_body.dart';
import '../models/response/pokemon_species_response.dart';
import 'package:poketter/core/endpoints/morpheme_endpoints.dart';

import '../models/body/pokemon_detail_body.dart';
import '../models/response/pokemon_detail_response.dart';

abstract class PokemonDetailRemoteDataSource {
  Future<EvolutionChainResponse> evolutionChain(
    EvolutionChainBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  });
  Future<PokemonSpeciesResponse> pokemonSpecies(
    PokemonSpeciesBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  });
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

  @override
  Future<PokemonSpeciesResponse> pokemonSpecies(
    PokemonSpeciesBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    final response = await http.get(
      MorphemeEndpoints.pokemonSpecies(body.id),
      body: body.toMap(),
      headers: headers,
      cacheStrategy: cacheStrategy ?? AsyncOrCacheStrategy(),
    );
    return PokemonSpeciesResponse.fromJson(response.body);
  }

  @override
  Future<EvolutionChainResponse> evolutionChain(
    EvolutionChainBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    final response = await http.get(
      MorphemeEndpoints.evolutionChain(body.id),
      body: body.toMap(),
      headers: headers,
      cacheStrategy: cacheStrategy ?? AsyncOrCacheStrategy(),
    );
    return EvolutionChainResponse.fromJson(response.body);
  }
}
