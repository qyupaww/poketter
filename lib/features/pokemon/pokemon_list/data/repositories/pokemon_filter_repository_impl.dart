import 'package:morpheme_http/morpheme_http.dart';

import '../../domain/repositories/pokemon_filter_repository.dart';
import '../datasources/pokemon_filter_remote_data_source.dart';

class PokemonFilterRepositoryImpl implements PokemonFilterRepository {
  PokemonFilterRepositoryImpl({required this.remoteDataSource});

  final PokemonFilterRemoteDataSource remoteDataSource;
  // simple in-memory caches for the app session
  final Map<String, Map<String, dynamic>> _generationCache = {};
  final Map<String, Map<String, dynamic>> _typeCache = {};
  Map<String, dynamic>? _generationListCache;
  Map<String, dynamic>? _typeListCache;
  Map<String, dynamic>? _pokemonAllCache;

  @override
  Future<Either<MorphemeFailure, Map<String, dynamic>>> generationList() async {
    try {
      if (_generationListCache != null) return Right(_generationListCache!);
      final data = await remoteDataSource.generationList();
      _generationListCache = data;
      return Right(data);
    } on MorphemeException catch (e) {
      return Left(e.toMorphemeFailure());
    } catch (e) {
      return Left(InternalFailure(e.toString()));
    }
  }

  @override
  Future<Either<MorphemeFailure, Map<String, dynamic>>> generation(
    String id,
  ) async {
    try {
      if (_generationCache.containsKey(id)) return Right(_generationCache[id]!);
      final data = await remoteDataSource.generation(id);
      _generationCache[id] = data;
      return Right(data);
    } on MorphemeException catch (e) {
      return Left(e.toMorphemeFailure());
    } catch (e) {
      return Left(InternalFailure(e.toString()));
    }
  }

  @override
  Future<Either<MorphemeFailure, Map<String, dynamic>>> typeList() async {
    try {
      if (_typeListCache != null) return Right(_typeListCache!);
      final data = await remoteDataSource.typeList();
      _typeListCache = data;
      return Right(data);
    } on MorphemeException catch (e) {
      return Left(e.toMorphemeFailure());
    } catch (e) {
      return Left(InternalFailure(e.toString()));
    }
  }

  @override
  Future<Either<MorphemeFailure, Map<String, dynamic>>> type(String id) async {
    try {
      if (_typeCache.containsKey(id)) return Right(_typeCache[id]!);
      final data = await remoteDataSource.type(id);
      _typeCache[id] = data;
      return Right(data);
    } on MorphemeException catch (e) {
      return Left(e.toMorphemeFailure());
    } catch (e) {
      return Left(InternalFailure(e.toString()));
    }
  }

  @override
  Future<Either<MorphemeFailure, Map<String, dynamic>>> pokemonAll({
    int limit = 2000,
    int offset = 0,
  }) async {
    try {
      if (_pokemonAllCache != null) return Right(_pokemonAllCache!);
      final data = await remoteDataSource.pokemonAll(
        limit: limit,
        offset: offset,
      );
      _pokemonAllCache = data;
      return Right(data);
    } on MorphemeException catch (e) {
      return Left(e.toMorphemeFailure());
    } catch (e) {
      return Left(InternalFailure(e.toString()));
    }
  }
}
