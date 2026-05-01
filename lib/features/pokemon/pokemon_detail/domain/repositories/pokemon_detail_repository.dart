import 'package:morpheme_http/morpheme_http.dart';

import '../../data/models/body/evolution_chain_body.dart';
import '../entities/evolution_chain_entity.dart';
import '../../data/models/body/pokemon_species_body.dart';
import '../entities/pokemon_species_entity.dart';
import '../../data/models/body/pokemon_detail_body.dart';
import '../entities/pokemon_detail_entity.dart';

abstract class PokemonDetailRepository {
  Future<Either<MorphemeFailure, PokemonDetailEntity>> pokemonDetail(
    PokemonDetailBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  });
  Future<Either<MorphemeFailure, PokemonSpeciesEntity>> pokemonSpecies(
    PokemonSpeciesBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  });
  Future<Either<MorphemeFailure, EvolutionChainEntity>> evolutionChain(
    EvolutionChainBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  });
}
