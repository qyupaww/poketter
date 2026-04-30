import 'package:morpheme_http/morpheme_http.dart';

import '../../domain/entities/pokemon_detail_entity.dart';
import '../../mapper.dart';
import '../../domain/repositories/pokemon_detail_repository.dart';
import '../datasources/pokemon_detail_remote_data_source.dart';
import '../models/body/pokemon_detail_body.dart';

class PokemonDetailRepositoryImpl implements PokemonDetailRepository {
  PokemonDetailRepositoryImpl({required this.remoteDataSource});

  final PokemonDetailRemoteDataSource remoteDataSource;

  @override
  Future<Either<MorphemeFailure, PokemonDetailEntity>> pokemonDetail(
    PokemonDetailBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    try {
      final data = await remoteDataSource.pokemonDetail(
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
