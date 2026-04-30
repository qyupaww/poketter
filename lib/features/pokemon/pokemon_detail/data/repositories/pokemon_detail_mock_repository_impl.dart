import 'package:morpheme_http/morpheme_http.dart';

import '../../domain/entities/pokemon_detail_entity.dart';
import '../../domain/repositories/pokemon_detail_repository.dart';
import '../models/body/pokemon_detail_body.dart';

class PokemonDetailMockRepositoryImpl implements PokemonDetailRepository {
  @override
  Future<Either<MorphemeFailure, PokemonDetailEntity>> pokemonDetail(
    PokemonDetailBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(PokemonDetailEntity.dummy());
  }
}
