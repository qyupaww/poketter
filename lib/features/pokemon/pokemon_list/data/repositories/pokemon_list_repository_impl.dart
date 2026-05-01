import 'package:morpheme_http/morpheme_http.dart';

import '../../domain/entities/pokemon_list_entity.dart';
import '../../mapper.dart';
import '../../domain/repositories/pokemon_list_repository.dart';
import '../datasources/pokemon_list_remote_data_source.dart';
import '../models/body/pokemon_list_body.dart';

class PokemonListRepositoryImpl implements PokemonListRepository {
  PokemonListRepositoryImpl({required this.remoteDataSource});

  final PokemonListRemoteDataSource remoteDataSource;

  @override
  Future<Either<MorphemeFailure, PokemonListEntity>> pokemonList(
    PokemonListBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    try {
      final data = await remoteDataSource.pokemonList(
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
