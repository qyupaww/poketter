import 'package:morpheme_http/morpheme_http.dart';

import '../../domain/entities/evolution_chain_entity.dart';
import '../models/body/evolution_chain_body.dart';
import '../../domain/entities/pokemon_species_entity.dart';
import '../models/body/pokemon_species_body.dart';
import '../../domain/entities/pokemon_detail_entity.dart';
import '../../mapper.dart';
import '../../domain/repositories/pokemon_detail_repository.dart';
import '../datasources/pokemon_detail_remote_data_source.dart';
import '../models/body/pokemon_detail_body.dart';

class PokemonDetailRepositoryImpl implements PokemonDetailRepository {
  PokemonDetailRepositoryImpl({required this.remoteDataSource});
  final PokemonDetailRemoteDataSource remoteDataSource;
  final Map<String, PokemonDetailEntity> _pokemonDetailCache = {};
  @override
  Future<Either<MorphemeFailure, PokemonDetailEntity>> pokemonDetail(
    PokemonDetailBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    try {
      if (_pokemonDetailCache.containsKey(body.id)) {
        return Right(_pokemonDetailCache[body.id]!);
      }
      final data = await remoteDataSource.pokemonDetail(
        body,
        headers: headers,
        cacheStrategy: cacheStrategy,
      );
      final entity = data.toEntity();
      _pokemonDetailCache[body.id] = entity;
      return Right(entity);
    } on MorphemeException catch (e) {
      return Left(e.toMorphemeFailure());
    } catch (e) {
      return Left(InternalFailure(e.toString()));
    }
  }

  @override
  Future<Either<MorphemeFailure, PokemonSpeciesEntity>> pokemonSpecies(
    PokemonSpeciesBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    try {
      final data = await remoteDataSource.pokemonSpecies(
        body,
        headers: headers,
        cacheStrategy: cacheStrategy,
      );
      return Right(data.toEntity());
    } on MorphemeException catch (e) {
      return Left(e.toMorphemeFailure());
    } catch (e) {
      return Left(InternalFailure(e.toString()));
    }
  }

  @override
  Future<Either<MorphemeFailure, EvolutionChainEntity>> evolutionChain(
    EvolutionChainBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    try {
      final data = await remoteDataSource.evolutionChain(
        body,
        headers: headers,
        cacheStrategy: cacheStrategy,
      );
      return Right(data.toEntity());
    } on MorphemeException catch (e) {
      return Left(e.toMorphemeFailure());
    } catch (e) {
      return Left(InternalFailure(e.toString()));
    }
  }
}
