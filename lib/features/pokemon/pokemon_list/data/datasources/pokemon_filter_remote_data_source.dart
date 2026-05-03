import 'dart:convert';

import 'package:morpheme_http/morpheme_http.dart';
import 'package:poketter/core/endpoints/morpheme_endpoints.dart';

abstract class PokemonFilterRemoteDataSource {
  Future<Map<String, dynamic>> generationList();
  Future<Map<String, dynamic>> generation(String id);

  Future<Map<String, dynamic>> typeList();
  Future<Map<String, dynamic>> type(String id);

  Future<Map<String, dynamic>> pokemonAll({int limit, int offset});
}

class PokemonFilterRemoteDataSourceImpl
    implements PokemonFilterRemoteDataSource {
  PokemonFilterRemoteDataSourceImpl({required this.http});

  final MorphemeHttp http;

  @override
  Future<Map<String, dynamic>> generationList() async {
    final res = await http.get(MorphemeEndpoints.generationList);
    return json.decode(res.body) as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> generation(String id) async {
    final res = await http.get(MorphemeEndpoints.generation(id));
    return json.decode(res.body) as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> typeList() async {
    final res = await http.get(MorphemeEndpoints.typeList);
    return json.decode(res.body) as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> type(String id) async {
    final res = await http.get(MorphemeEndpoints.type(id));
    return json.decode(res.body) as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> pokemonAll({
    int limit = 2000,
    int offset = 0,
  }) async {
    final res = await http.get(
      MorphemeEndpoints.pokemonAll(limit: limit, offset: offset),
    );
    return json.decode(res.body) as Map<String, dynamic>;
  }
}
