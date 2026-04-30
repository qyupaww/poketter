import 'package:morpheme_http/morpheme_http.dart';

import '../../domain/entities/pokemon_list_entity.dart';
import '../../domain/repositories/pokemon_list_repository.dart';
import '../models/body/pokemon_list_body.dart';

class PokemonListMockRepositoryImpl implements PokemonListRepository {
  @override
  Future<Either<MorphemeFailure, PokemonListEntity>> pokemonList(
    PokemonListBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(PokemonListEntity.dummy());
  }
}
