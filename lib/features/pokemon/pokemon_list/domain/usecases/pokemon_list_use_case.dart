import 'package:morpheme_http/morpheme_http.dart';

import '../../data/models/body/pokemon_list_body.dart';
import '../entities/pokemon_list_entity.dart';
import '../repositories/pokemon_list_repository.dart';

class PokemonListUseCase
    implements UseCase<PokemonListEntity, PokemonListBody> {
  PokemonListUseCase({required this.repository});

  final PokemonListRepository repository;

  @override
  Future<Either<MorphemeFailure, PokemonListEntity>> call(
    PokemonListBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) {
    return repository.pokemonList(
      body,
      headers: headers,
      cacheStrategy: cacheStrategy,
    );
  }
}
