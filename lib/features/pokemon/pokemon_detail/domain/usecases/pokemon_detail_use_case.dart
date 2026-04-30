import 'package:morpheme_http/morpheme_http.dart';

import '../../data/models/body/pokemon_detail_body.dart';
import '../entities/pokemon_detail_entity.dart';
import '../repositories/pokemon_detail_repository.dart';

class PokemonDetailUseCase
    implements UseCase<PokemonDetailEntity, PokemonDetailBody> {
  PokemonDetailUseCase({required this.repository});

  final PokemonDetailRepository repository;

  @override
  Future<Either<MorphemeFailure, PokemonDetailEntity>> call(
    PokemonDetailBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) {
    return repository.pokemonDetail(
      body,
      headers: headers,
      cacheStrategy: cacheStrategy,
    );
  }
}
