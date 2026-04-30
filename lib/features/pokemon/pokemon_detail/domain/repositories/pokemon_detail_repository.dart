import 'package:morpheme_http/morpheme_http.dart';

import '../../data/models/body/pokemon_detail_body.dart';
import '../entities/pokemon_detail_entity.dart';

abstract class PokemonDetailRepository {
  Future<Either<MorphemeFailure, PokemonDetailEntity>> pokemonDetail(
    PokemonDetailBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  });
}
