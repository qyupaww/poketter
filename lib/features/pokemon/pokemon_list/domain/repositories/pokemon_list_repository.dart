import 'package:morpheme_http/morpheme_http.dart';

import '../../data/models/body/pokemon_list_body.dart';
import '../entities/pokemon_list_entity.dart';

abstract class PokemonListRepository {
  Future<Either<MorphemeFailure, PokemonListEntity>> pokemonList(
    PokemonListBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  });
}
