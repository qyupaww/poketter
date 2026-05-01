import 'package:morpheme_http/morpheme_http.dart';

import '../../domain/entities/evolution_chain_entity.dart';
import '../models/body/evolution_chain_body.dart';
import '../../domain/entities/pokemon_species_entity.dart';
import '../models/body/pokemon_species_body.dart';
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

  @override
  Future<Either<MorphemeFailure, PokemonSpeciesEntity>> pokemonSpecies(
    PokemonSpeciesBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(PokemonSpeciesEntity.dummy());
  }

  @override
  Future<Either<MorphemeFailure, EvolutionChainEntity>> evolutionChain(
    EvolutionChainBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(EvolutionChainEntity.dummy());
  }
}
