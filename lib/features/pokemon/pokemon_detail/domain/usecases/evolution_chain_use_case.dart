import 'package:morpheme_http/morpheme_http.dart';

import '../../data/models/body/evolution_chain_body.dart';
import '../entities/evolution_chain_entity.dart';
import '../repositories/pokemon_detail_repository.dart';

class EvolutionChainUseCase
    implements UseCase<EvolutionChainEntity, EvolutionChainBody> {
  EvolutionChainUseCase({required this.repository});

  final PokemonDetailRepository repository;

  @override
  Future<Either<MorphemeFailure, EvolutionChainEntity>> call(
    EvolutionChainBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) {
    return repository.evolutionChain(
      body,
      headers: headers,
      cacheStrategy: cacheStrategy,
    );
  }
}
